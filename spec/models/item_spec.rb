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

      @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
      @customer3 = Customer.create!(first_name: "John", last_name: "Smith")
      @customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
      @customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
      @customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
      @customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")

      @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
      @item2 = Item.create!(name: "golden eggs", description: "real gold yo.", unit_price: 38432112, merchant_id: @merchant1.id, enabled: false)

      @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id)
      @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id)
      @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id)
      @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id)
      @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id)
      @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id)

      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
      @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 9, unit_price: 23324, status: "packaged")
      @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
      @invoice_item4 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
      @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 9, unit_price: 23324, status: "pending")
      @invoice_item6 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
      @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")

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
      expect(@item1.all_invoices).to eq([@invoice1, @invoice2, @invoice3, @invoice4, @invoice5, @invoice6])
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
      expect(@merchant1.items.disabled).to eq([@item2])

    end
  end

end