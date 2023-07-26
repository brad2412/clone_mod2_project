class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  
  def self.top_customers
    # binding.pry
    Customer.joins(:transactions)
            .where(transactions: { result: "success" })
            .group(:id)
            .order("COUNT(transactions.id) DESC")
            .limit(5)
  end

  def total_transactions
    transactions.where(result: "success").count
  end

end