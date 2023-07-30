class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoices

  validates :quantity, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :unit_price, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :status, presence: true

  enum :status, [:shipped, :packaged, :pending]

  def formatted_price
    price = unit_price/100.to_f
    formatted_amount = sprintf("$%.2f", price)
    if formatted_amount.length > 7
      formatted_amount = formatted_amount.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end
    formatted_amount
  end
end