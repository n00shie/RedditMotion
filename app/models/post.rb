class Post

  attr_accessor :title, :author, :thumbnailURL, :url,  :isSelf, :permalink

  def initialize(attributes = {})
    self.title = attributes["title"]
    self.author = attributes["author"]
    self.thumbnailURL = attributes["thumbnail"].to_url
    self.url = attributes["url"]
    self.isSelf = attributes["is_self"]
    self.permalink = attributes["permalink"]
  end
  
  def self.get_posts(&callback)
    AFMotion::Client.shared.get("hot.json") do |result|
      if result.success?
        posts = []
        result.object['data']['children'].each do |attributes|
          posts << Post.new(attributes['data'])
        end
        callback.call(posts, nil)
      else
        callback.call([], result.error)
      end
    end

  end
end