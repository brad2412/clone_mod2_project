class PicturesController < ApplicationController
  def index
    # @facade = PhotoFacade.new(params[:id])
  end

end

# class SearchController < ApplicationController
#   def index
#     @facade = SearchFacade.new(params[:state])
#   end

#   def search
#     conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
#       faraday.headers["X-API-KEY"] = ENV["PROPUBLICA_API_KEY"]
#     end
#     response = conn.get("/congress/v1/116/senate/members.json")

#     data = JSON.parse(response.body, symbolize_names: true)

#     members = data[:results][0][:members]

#     found_members = members.find_all {|m| m[:last_name] == params[:search]}
#     @member = found_members.first
#     render "welcome/index"
#   end
# end