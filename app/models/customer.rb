class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def total_transactions
    transactions.where(result: "success").count
  end
  def self.top_customers
    # binding.pry
    Customer.joins(:transactions)
            .where(transactions: { result: "success" })
            .group(:id)
            .order("COUNT(transactions.id) DESC")
            .limit(5)
  end


end
