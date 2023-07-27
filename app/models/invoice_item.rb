class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :unit_price, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :status, presence: true

end