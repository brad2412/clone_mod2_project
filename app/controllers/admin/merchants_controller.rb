class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
      if params[:name].present?
        merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant)
        flash[:success] = "Merchant was successfully updated"
      elsif params[:enabled].present?
        merchant.update(merchant_params)
        redirect_to admin_merchants_path
      else 
        redirect_to edit_admin_merchant_path(merchant)
        flash[:error] = "Please fill in the name"
      end
  end

  def new

  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
      flash[:notice] = "#{merchant.name} was successfully created"
    else 
      redirect_to new_admin_merchant_path
      flash[:error] = "Please fill in the name"
    end
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end