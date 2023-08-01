class Merchants::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
      if params[:enabled].present?
        @item.update(enabled: params[:enabled])
        redirect_to merchant_items_path(@merchant)
      elsif @item.update(item_params)
        redirect_to merchant_item_path(@merchant, @item)
        flash[:success] = "Item was successfully updated"
      else
        redirect_to edit_merchant_item_path(@merchant, @item)
        flash[:error] = "Please fill in all fields"
      end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      redirect_to merchant_items_path(@merchant)
      flash[:success] = "Item created successfully."
    else 
      redirect_to new_merchant_item_path(@merchant)
      flash[:error] = "Please fill in all fields"
    end
  end

  private 

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end