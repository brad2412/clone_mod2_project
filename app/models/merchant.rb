class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_5_customers
    customers
      .select('customers.*, COUNT(transactions.id) as success_transacts')
      .joins(invoices: :transactions)
      .where(transactions: { result: "success" })
      .group('customers.id')
      .order('success_transacts DESC')
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items).where(invoice_items: { status: "packaged" })
  end

  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end
  

  def total_revenue
    items.joins(:transactions)
      .where(transactions: {result: "success"})
      .sum('invoice_items.quantity*invoice_items.unit_price')
  end

  def formatted_total_revenue  # this method is repeated in item, invoice, and invoice_item possible rename and move to application_record?
    revenue = total_revenue/100.00
    formatted_amount = sprintf("$%.2f", revenue)
    if formatted_amount.length > 7
      formatted_amount = formatted_amount.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end
    formatted_amount
  end

  def self.top_5_by_total_revenue
    select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
      .joins(:transactions)
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue desc')
      .limit(5)
  end

  def best_day
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