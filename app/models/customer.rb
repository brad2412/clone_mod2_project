class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def self.top_customers
    Customer.joins(:transactions)
    .where(transactions: { result: "success" })
    .group(:id)
    .select('customers.*, COUNT(transactions.id) AS total_transactions')
    .order("total_transactions DESC")
    .limit(5)
  end

  def full_name
    first_name + " " + last_name
  end
end
