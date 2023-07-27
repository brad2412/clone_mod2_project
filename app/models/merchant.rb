class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  def self.top_5_customers
    Merchant.joins(items: {invoices: :transactions})
            .where(transactions: { result: "success" })
            .group(:id)
            .order("COUNT(transactions.id) DESC")
            .limit(5)
  end

  def self.total_transactions
    Merchant.joins(items: {invoices: :transactions}).where(transactions: {result: "success" }).count
  end

end