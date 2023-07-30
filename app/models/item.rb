class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :unit_price, presence: true, numericality: { greater_then_or_equal_to: 0}


  def all_invoices
    invoices.order(:created_at).distinct
  end

  def formatted_unit_price  # this method is repeated in merchant, invoice, and invoice_item possible rename and move to application_record?
    price = self.unit_price/100.00
    formatted_price = sprintf("$%.2f", price)
    if formatted_price.length > 7
      formatted_price = formatted_price.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end
      formatted_price
  end

end
