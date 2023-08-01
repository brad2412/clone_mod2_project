require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do 
    it { should belong_to :item }
    it { should belong_to :invoice }
    # it { should have_many(:transactions).through(:invoice) }
  end

  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe "#format_money" do #exists in application record
    it "returns the price formatted" do
      @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)

      @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant1.id)

      @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")

      @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
      
      @invoice_item1 = InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 5, unit_price: 3476, status: "pending")
      @invoice_item2 = InvoiceItem.create!(invoice: @invoice1, item: @item2, quantity: 4, unit_price: 802, status: "packaged")
      @invoice_item3 = InvoiceItem.create!(invoice: @invoice1, item: @item3, quantity: 465, unit_price: 34568765, status: "shipped")
      @invoice_item4 = InvoiceItem.create!(invoice: @invoice1, item: @item4, quantity: 23, unit_price: 1509, status: "shipped")

      expect(@invoice_item1.format_money(:unit_price)).to eq("$34.76")
      expect(@invoice_item2.format_money(:unit_price)).to eq("$8.02")
      expect(@invoice_item3.format_money(:unit_price)).to eq("$345,687.65")
      expect(@invoice_item4.format_money(:unit_price)).to eq("$15.09")
    end
  end
end