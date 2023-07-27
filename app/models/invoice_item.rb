class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoices

  enum :status, [:shipped, :packaged, :pending]
end