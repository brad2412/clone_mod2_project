require "rails_helper"

RSpec.describe ApplicationRecord do
  before do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "Targete", enabled: true)

    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 23324, status: "pending")
  end

  describe "#format_money" do
    it "can format money with a given argument" do
      expect(@item1.format_money(:unit_price)).to eq("$13.37")
      expect(@invoice1.format_money(:total_revenue)).to eq("$2,780.91")
      expect(@invoice1.format_money(:revenue_for, @merchant1)).to eq("$681.75")
    end
  end
end