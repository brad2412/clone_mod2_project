class UnsplashService
  def logo
    response = connection.get("/photos/lhgCCLv1G0k")
    Photo.new(JSON.parse(response.body))
  end

  def connection
    Faraday.new(url: "https://api.unsplash.com/", params: {"client_id" => ENV["UNSPLASH_API_KEY"]})
  end
end