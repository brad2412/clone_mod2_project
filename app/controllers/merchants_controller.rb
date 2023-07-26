class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
    @customer = Customer.all
    @transaction = Transaction.all
  end
end