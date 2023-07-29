class Merchant < ApplicationRecord
  validates :name, presence: true

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

  # def transactions_count
  #   transactions.where(result: "success").count
  # end
end