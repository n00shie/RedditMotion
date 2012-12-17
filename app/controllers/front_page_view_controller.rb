class FrontPageViewController < UITableViewController
  attr_accessor :posts
  attr_accessor :activityIndicatorView
  
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
        p posts
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

  def viewDidLoad
    super

    self.title = "Front Page"

    self.activityIndicatorView = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
    self.activityIndicatorView.hidesWhenStopped = true

    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(self.activityIndicatorView)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target:self, action: 'reload')

    self.reload



    # menuButtonImage = UIImage.imageNamed("menu_button_resting.png")
    # menuButtonFrame = CGRectMake(0, 0, 44, 44)
    # menuButton = UIButton.alloc.initWithFrame(menuButtonFrame)
    # menuButton.addTarget(self.viewDeckController, action:'toggleLeftView', forControlEvents:UIControlEventTouchUpInside)
    # menuButton.setBackgroundImage(menuButtonImage, forState:UIControlStateNormal)
    # #leftButton =  UIBarButtonItem.alloc.initWithTitle("Menu", style: UIBarButtonItemStyleBordered, target:self.viewDeckController, action:'toggleLeftView')

    # menuBut = UIBarButtonItem.alloc.initWithCustomView(menuButton)
    # self.navigationItem.leftBarButtonItem = menuBut
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

  def getCellContentView(cellIdentifier)
 
    cellFrame = CGRectMake(0, 0, 300, 44)
    cell = UITableViewCell.alloc.initWithFrame(cellFrame, reuseIdentifier:cellIdentifier)

    textLabelFrame = CGRectMake(5, 0, 320-44, 44)
    textLabel = UILabel.alloc.initWithFrame(textLabelFrame)
    textLabel.tag = 10
    textLabel.font = UIFont.fontWithName('Gibson-SemiBold', size:14)
    textLabel.textColor = UIColor.blackColor
    cell.contentView.addSubview(textLabel)

    avatarImage = UIImage.imageNamed("avatar_image.png")
    avatarFrame = CGRectMake(276, 0, 44, 44)
    avatarButton = UIButton.alloc.initWithFrame(avatarFrame, target:self, action:'didClickAvatarButton')
    avatarButton.tag = 20
    avatarButton.setBackgroundImage(avatarImage, forState:UIControlStateNormal)

    cell.contentView.addSubview(avatarButton)

    cell
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @@identifier ||= "Cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@@identifier) || begin
      PostTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@@identifier)
    end

    cell.post = self.posts[indexPath.row]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  end
end