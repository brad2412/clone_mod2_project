class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoices

  validates :quantity, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :unit_price, presence: true, numericality: { greater_then_or_equal_to: 0}
  validates :status, presence: true

  enum :status, [:shipped, :packaged, :pending]

  def formatted_price   # this method is repeated in item, invoice, and merchant possible rename and move to application_record?
    price = unit_price/100.00
    formatted_amount = sprintf("$%.2f", price)
    if formatted_amount.length > 7
      formatted_amount = formatted_amount.gsub!(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end
    formatted_amount
  end
end

# The regular expression uses a positive lookahead (?=\\d{3}+(?!\\d)) to match any digit \\d
# that is followed by groups of three digits (\\d{3})+ and not followed by another digit (?!\\d).
# This allows the regex to match the locations where commas should be inserted to separate thousands.
# The replacement "\\1," places a comma after the matched digit \\1, effectively adding the comma as the thousands separator.