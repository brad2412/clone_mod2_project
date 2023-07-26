class Admin::ApplicationController < ApplicationController
  def welcome
    @top_customers = Customer.top_customers
  end
end