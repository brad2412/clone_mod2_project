require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do 
    it {should belong_to :merchant }
    it {should have_many :invoice_items }
    it {should have_many(:invoices).through(:invoice_items) }
    it {should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
  end
  before(:each) do
      @merchant1 = Merchant.create!(name: "Safeway")
      @merchant2 = Merchant.create!(name: "Targete", enabled: true)

      @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
      @customer3 = Customer.create!(first_name: "John", last_name: "Smith")
      @customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
      @customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
      @customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
      @customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
      @customer8 = Customer.create!(first_name: "Smelly", last_name: "Cow")

      @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
      @item2 = Item.create!(name: "golden eggs", description: "real gold yo.", unit_price: 38432112, merchant_id: @merchant1.id, enabled: false)
      @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id, enabled: false)
      @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id, enabled: false)
      @item5 = Item.create!(name: "Poo tay toe", description: "spuds", unit_price: 5678, merchant_id: @merchant1.id, enabled: false)
      @item6 = Item.create!(name: "burrito", description: "spicey", unit_price: 8765, merchant_id: @merchant1.id, enabled: false)

      @invoice1 = Invoice.create!(status: "completed", customer: @customer1, created_at: Time.new(2015,5,3))
      @invoice2 = Invoice.create!(status: "completed", customer: @customer2, created_at: Time.new(2015,5,3))
      @invoice3 = Invoice.create!(status: "completed", customer: @customer3, created_at: Time.new(2015,5,3))
      @invoice4 = Invoice.create!(status: "completed", customer: @customer4, created_at: Time.new(2015,5,3))
      @invoice5 = Invoice.create!(status: "completed", customer: @customer5, created_at: Time.new(2015,5,3))
      @invoice6 = Invoice.create!(status: "completed", customer: @customer6, created_at: Time.new(2015,5,3))
      @invoice7 = Invoice.create!(status: "completed", customer: @customer6, created_at: Time.new(2015,5,3))
      @invoice8 = Invoice.create!(status: "completed", customer: @customer8, created_at: Time.new(2015,5,3))


      @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 5, unit_price: 13635, status: "packaged")
      @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 9, unit_price: 234324, status: "packaged")
      @invoice_item3 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 9, unit_price: 2324, status: "pending")
      @invoice_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 9, unit_price: 13394, status: "pending")
      @invoice_item5 = InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 9, unit_price: 2324, status: "shipped")
      @invoice_item5 = InvoiceItem.create!(item: @item1, invoice: @invoice5, quantity: 9, unit_price: 2324, status: "shipped")
      @invoice_item6 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 9, unit_price: 3324, status: "shipped")
      @invoice_item7 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 9, unit_price: 235324, status: "shipped")

      @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 0)
      @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
      @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
      @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
      @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
      @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
      @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)

  end

  describe "#all_invoices" do
    it "should return all invoices" do
      expect(@item1.all_invoices).to eq([@invoice1, @invoice5])
      expect(@item1.all_invoices).to_not eq([@invoice7])
    end
  end

  describe "formatted unit price" do
    it "should return item price formatted in dollars and cents" do
      expect(@item1.format_money(@item1.unit_price)).to eq("$13.37")
      expect(@item2.format_money(@item2.unit_price)).to eq("$384,321.12")
      expect(@item1.format_money(@item1.unit_price)).to_not eq(1337)
    end
  end
    
  describe "#enabled" do
    it "returns only enabled items" do
      expect(@merchant1.items.enabled).to eq([@item1])
    end
  end
  
  describe "#disabled" do
    it "returns only disabled items" do
      expect(@merchant1.items.disabled).to eq([@item2, @item3, @item5, @item6])
    end
  end

  describe "#top_5_items_by_total_revenue" do
    it "returns the top 5 items of a merhant by total revenue on invoices with >= 1 successful transactions" do
      top_5_merchant_items = @merchant1.items.top_5_items_by_total_revenue

      expect(top_5_merchant_items).to eq([@item6, @item2, @item1, @item3, @item5])
    end
  end

  describe "#best_item_day" do
    it "returns the items best day by revenue generated on invoices..." do
      best_day = @merchant1.items.first.best_item_day

      expect(best_day).to eq("Sunday, May 3, 2015")
    end
  end
end