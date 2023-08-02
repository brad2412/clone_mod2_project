class Photo 
  attr_reader :likes,
              :urls
  def initialize(data)
    @urls = data["urls"]
    @likes = data["likes"]
  end
end