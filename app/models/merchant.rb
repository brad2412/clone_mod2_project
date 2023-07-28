class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  # has_many :invoices, through: :invoice_items
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
  

  def total_revenue
    success = invoices.joins(:transactions)
                      .where(transactions: { result: "success" })
                      .distinct
                      .pluck(:id)

    InvoiceItem.joins(:invoice)
                .where(invoice_id: success)
                .sum('quantity * unit_price')
  end
  # Notes on Revenue Calculation:
  # - Only invoices with at least one successful transaction should count towards revenue
  # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price) 
end