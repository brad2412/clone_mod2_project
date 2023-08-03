class PhotoService

  def logo_pic
    get_url("https://api.unsplash.com/photos/lhgCCLv1G0k?client_id=cmdGsW8aygaTdOnED6JNq1cEXx5NPjCmsKojQ71OSKw")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def item_image
    # get_url("insert here")
  end

  def merchant_image
    # get_url("insert here")
  end
end


# class CongressService
#   def members_by_state(state)
#     get_url("/congress/v1/members/house/#{state}/current.json")
#   end

#   def get_url(url)
#     response = conn.get(url)
#     JSON.parse(response.body, symbolize_names: true)
#   end

#   def conn
#     Faraday.new(url: "https://api.propublica.org") do |faraday|
#       faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
#     end
#   end
# end