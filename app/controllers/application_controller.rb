class ApplicationController < ActionController::Base
  before_action :logo
  def logo
    @logo = UnsplashService.new.logo
  end
end
