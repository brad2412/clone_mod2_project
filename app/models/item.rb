class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0}


  def all_invoices
    invoices.order(:created_at).distinct
  end
  
  def self.enabled
    where(enabled: true)
  end
  
  def self.disabled
    where(enabled: false)
  end
end
