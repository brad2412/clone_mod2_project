class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :unit_price, presence: true, numericality: { greater_then_or_equal_to: 0}


  def all_invoices
    invoices.all.distinct
  end
end