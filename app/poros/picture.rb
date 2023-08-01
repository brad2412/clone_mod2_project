class Photo
  attr_reader :likes,
              :urls,
              :source

  def initialize(data)
    # @description = ?
    # @link = data[:link]
    # @properties = ?
    @likes = data[:likes]
    @urls = data[:urls]
    @source = urls[:small]
  end

  def self.generate(data)
    photo = self.new(data)
    photo
  end

end