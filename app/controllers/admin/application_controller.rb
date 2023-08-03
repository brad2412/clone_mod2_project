class Admin::ApplicationController < ApplicationController
  def welcome
    @top_customers = Customer.top_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end