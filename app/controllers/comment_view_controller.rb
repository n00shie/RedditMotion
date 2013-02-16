class CommentViewController < UIViewController
  attr_accessor :post
  def viewDidLoad
    super
    self.title = "Comments"
    
    request = NSURLRequest.requestWithURL(("www.reddit.com" + self.post.permalink).to_url)
    webView = UIWebView.alloc.init
    webView.loadRequest(request)

  end

  def setPost(post)
    self.post = post
  end

end