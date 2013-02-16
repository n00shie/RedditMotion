class FrontPageViewController < UITableViewController
  attr_accessor :posts
  attr_accessor :activityIndicatorView
  

   def viewDidLoad
    super

    self.title = "Front Page"

    self.activityIndicatorView = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
    self.activityIndicatorView.hidesWhenStopped = true

    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(self.activityIndicatorView)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target:self, action: 'reload')
    
    self.tableView.rowHeight = 70
    $i = self
    self.reload
  end

  def reload
    self.activityIndicatorView.startAnimating
    self.navigationItem.rightBarButtonItem.enabled = true

    Post.get_posts do |posts, error|
      if (error)
        UIAlertView.alloc.initWithTitle("Error",
          message:error.localizedDescription,
          delegate:nil,
          cancelButtonTitle:nil,
          otherButtonTitles:"OK", nil).show
      else
        self.posts = posts
      end

      self.activityIndicatorView.stopAnimating
      self.navigationItem.rightBarButtonItem.enabled = true
    end
  end

  def posts
    @posts ||= []
  end

  def posts=(posts)
    @posts = posts
    self.tableView.reloadData
    @posts
  end

  def viewDidUnload
    self.activityIndicatorView = nil
    super
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

  def tableView(tableView, numberOfRowsInSection:section)
    self.posts.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @@identifier ||= "Cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@@identifier) || begin
      PostTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@@identifier)
    end

    cell.post = @posts[indexPath.row]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    post = @posts[indexPath.row]
    postViewTabBarController = PostViewTabBarController.alloc.initWithTitle(post.title)
    postViewTabBarController.post = post

    self.navigationController.pushViewController(postViewTabBarController, animated:true)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  end
end