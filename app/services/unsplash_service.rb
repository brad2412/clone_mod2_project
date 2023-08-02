class UnsplashService
  def logo
    response = connection.get("/photos/lhgCCLv1G0k")
    Photo.new(JSON.parse(response.body))
  end

  def item_image(keyword)
    response = connection.get("/photos?order_by&query=#{keyword}")
    first_photo = (JSON.parse(response.body)).sample
    Photo.new(first_photo)
  end

  def merchant_image
    response = connection.get("/photos/random")
    Photo.new(JSON.parse(response.body))
  end

  def connection
    Faraday.new(url: "https://api.unsplash.com/", params: {"client_id" => ENV["UNSPLASH_API_KEY"]})
  end
end