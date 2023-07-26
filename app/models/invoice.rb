class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum :status, ["cancelled", "completed", "in progress"]

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not(invoice_items: {status: 0})
  end
end