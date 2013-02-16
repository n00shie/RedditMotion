class PostViewTabBarController < UITabBarController
  attr_accessor :post

  def initWithTitle(title)
    self.title = title
    commentView = CommentViewController.alloc.init
    postView = PostViewController.alloc.init
    self.viewControllers = [postView, commentView]
    #request = NSURLRequest.requestWithURL(("www.reddit.com" + @post.permalink).to_url)
  end

  def setPost(post)
    self.post = post
    self.title = post.title
  end

  def post
    @post
  end
end