class PostTableViewCell < UITableViewCell
  attr_accessor :post

  def initWithStyle(style, reuseIdentifier:reuseIdentifier)
    super

    self.textLabel.textColor = UIColor.darkGrayColor
    self.detailTextLabel.font = UIFont.systemFontOfSize 12
    self.detailTextLabel.numberOfLines = 0
    self.selectionStyle = UITableViewCellSelectionStyleGray

    self
  end

  def post=(post)
    @post = post

    self.textLabel.text = @post.title
    self.detailTextLabel.text = @post.author
    
    if @post.thumbnailURL != nil
      self.imageView.url = {url: @post.thumbnailURL}
    end

    self.setNeedsLayout

    @post
  end

  def layoutSubviews
    super

    self.imageView.frame = CGRectMake(10, 10, 50, 50);
    self.textLabel.frame = CGRectMake(70, 10, 240, 20);

    detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0, 25);
    self.detailTextLabel.frame = detailTextLabelFrame
  end
end