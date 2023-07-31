class Invoice < ApplicationRecord
  belongs_to :customer
  # has_one :merchant, through: :items
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates :status, presence: true

  enum :status, ["cancelled", "completed", "in progress"]

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not(invoice_items: {status: 0}).order(created_at: :desc).distinct
  end

  def formatted_date
    created_at.strftime("%A, %B %-d, %Y")
  end

  def total_revenue
    invoice_items.sum('quantity*unit_price')
  end

  def items_for(merchant)
    items.where('merchant_id = ?', merchant.id)
  end
end