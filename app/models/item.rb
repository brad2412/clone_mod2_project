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
  
  def self.top_5_items_by_total_revenue
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(:transactions)
      .where(transactions: { result: "success" })
      .group(:id)
      .order('revenue desc')
      .limit(5)
  end

  def best_item_day
    invoices.select("invoices.created_at, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .group('invoices.created_at')
    .order('revenue desc, invoices.created_at desc')
    .limit(1)
    .first
    .created_at
    .strftime("%A, %B %-d, %Y")
  end
end
