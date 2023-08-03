class Merchants::InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:status])
    redirect_to merchant_invoice_path(params[:merchant_id], invoice_item.invoice)
  end
end