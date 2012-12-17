class Post

  attr_accessor :title, :thumbnail, :url,  :is_self

  def initialize(attributes = {})
    self.title = attributes["title"].to_s
    self.thumbnail = attributes["thumbnail"]
    self.url = attributes["url"]
    self.is_self = attributes["is_self"]
  end
  
  def self.get_posts(&callback)
    AFMotion::JSON.get("http://reddit.com/hot.json") do |result|
      if result.success?
        posts = []
        result.object['data']['children'].each do |attributes|
          #posts << Post.new(attributes)
          p attributes['data']
          p "\n"
        end
        callback.call(posts, nil)
      else
        callback.call([], result.error)
      end
    end

  end


 # def self.fetchGlobalTimelinePosts(&callback)
 #    AFMotion::Client.shared.get("stream/0/posts/stream/global") do |result|
 #      if result.success?
 #        posts = []
 #        result.object["data"].each do |attributes|
 #          posts << Post.new(attributes)
 #        end
 #        callback.call(posts, nil)
 #      else
 #        callback.call([], result.error)
 #      end
 #    end
 #  end
end