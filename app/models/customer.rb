class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  # has_many :merchants, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def self.top_customers
    Customer.joins(:transactions)
    .where(transactions: { result: "success" })
    .group(:id)
    .order("COUNT(transactions.id) DESC")
    .limit(5)
  end
  
  def total_transactions
    transactions.where( result: "success").count
  end

  def full_name
    first_name + " " + last_name
  end
end
