class Invoice < ApplicationRecord
  belongs_to :customer
  has_one :merchant, through: :items
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

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

  def formatted_revenue
    revenue = total_revenue/100.to_f
    formatted_amount = sprintf("$%.2f", revenue)
    if formatted_amount.length > 7
      formatted_amount = formatted_amount.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end
    formatted_amount
  end
end