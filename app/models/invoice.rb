class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum :status, ["cancelled", "completed", "in progress"]

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not(invoice_items: {status: 0}).order(created_at: :desc)
  end

  def formatted_date
    created_at.strftime("%A, %B %e, %Y")
  end
end