class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  
  def self.top_customers
    binding.pry
    Customer.joins(:transactions).where(transactions: {result: "success"})
  end

  def total_transactions
    transactions.count
  end

end