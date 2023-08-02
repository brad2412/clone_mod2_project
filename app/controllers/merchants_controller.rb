class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_image = UnsplashService.new.merchant_image
  end
end