class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_5_customers
    customers.joins(:transactions)
              .where(transactions: { result: "success" })
              .group(:id)
              .order("COUNT(transactions.id) DESC")
              .limit(5)
  end

  def items_ready_to_ship
    Item.joins(:invoice_items).where(invoice_items: { status: "packaged" })
  end

  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end
end