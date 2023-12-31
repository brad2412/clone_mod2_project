require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "Targete", enabled: true)
    @merchant3 = Merchant.create!(name: "Fifteen Bears", enabled: true)
    @merchant4 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant5 = Merchant.create!(name: "Freddy Meyers", enabled: false)
    @merchant6 = Merchant.create!(name: "Timmy Hortons", enabled: false)
    @merchant7 = Merchant.create!(name: "ZaZa", enabled: false)
    @merchant1_items = create_list(:item, 10, merchant: @merchant1)
    @merchant2_items = create_list(:item, 10, merchant: @merchant2)
    @merchant3_items = create_list(:item, 10, merchant: @merchant3)
    @merchant4_items = create_list(:item, 10, merchant: @merchant4)
    @merchant5_items = create_list(:item, 10, merchant: @merchant5)
    @merchant6_items = create_list(:item, 10, merchant: @merchant6)
    @merchant7_items = create_list(:item, 10, merchant: @merchant7)
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    @customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    @customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    @customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    @customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
    @customer8 = Customer.create!(first_name: "Smelly", last_name: "Cow")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)


    @customer1_invoices = create_list(:invoice, 5, customer: @customer1, created_at: Time.new(2014,6,5))
    @customer2_invoices = create_list(:invoice, 5, customer: @customer2, created_at: Time.new(1998,4,7))
    @customer3_invoices = create_list(:invoice, 5, customer: @customer3, created_at: Time.new(1900,7,6))
    @customer4_invoices = create_list(:invoice, 5, customer: @customer4, created_at: Time.new(1997,7,6))
    @customer5_invoices = create_list(:invoice, 5, customer: @customer5, created_at: Time.new(1987,5,4))
    @customer6_invoices = create_list(:invoice, 5, customer: @customer6, created_at: Time.new(2001,6,5))
    @customer7_invoices = create_list(:invoice, 5, customer: @customer7, created_at: Time.new(2003,7,6))
    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: Time.new(2012,3,4))
    @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id, created_at: Time.new(2000,5,6))
    @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id, created_at: Time.new(1999,5,6))
    @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id, created_at: Time.new(2030,5,4))
    @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2012,5,4))
    @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2016,7,6))
    @invoice8 = Invoice.create!(status: "completed", customer_id: @customer8.id, created_at: Time.new(2015,5,3))

    
    @invoice_item1 = InvoiceItem.create!(invoice: @customer1_invoices[0], item: @merchant1_items[0], unit_price: 423, quantity: 4)
    @invoice_item2 = InvoiceItem.create!(invoice: @customer1_invoices[2], item: @merchant1_items[4], unit_price: 5463, quantity: 6)
    @invoice_item3 = InvoiceItem.create!(invoice: @customer1_invoices[3], item: @merchant1_items[5], unit_price: 543, quantity: 9)
    @invoice_item4 = InvoiceItem.create!(invoice: @customer1_invoices[1], item: @merchant1_items[6], unit_price: 543, quantity: 3)
    @invoice_item5 = InvoiceItem.create!(invoice: @customer2_invoices[0], item: @merchant1_items[6], unit_price: 54, quantity: 8)
    @invoice_item6 = InvoiceItem.create!(invoice: @customer2_invoices[1], item: @merchant2_items[0], unit_price: 7465, quantity: 4)
    @invoice_item7 = InvoiceItem.create!(invoice: @customer2_invoices[4], item: @merchant2_items[3], unit_price: 45322, quantity: 3)
    @invoice_item8 = InvoiceItem.create!(invoice: @customer3_invoices[0], item: @merchant3_items[0], unit_price: 76556, quantity: 2)
    @invoice_item9 = InvoiceItem.create!(invoice: @customer3_invoices[2], item: @merchant3_items[3], unit_price: 6453, quantity: 1)
    @invoice_item10 = InvoiceItem.create!(invoice: @customer3_invoices[4], item: @merchant4_items[7], unit_price: 4532, quantity: 8)
    @invoice_item11 = InvoiceItem.create!(invoice: @customer4_invoices[0], item: @merchant4_items[7], unit_price: 9876, quantity: 4)
    @invoice_item12 = InvoiceItem.create!(invoice: @customer4_invoices[3], item: @merchant4_items[9], unit_price: 4533, quantity: 4)
    @invoice_item13 = InvoiceItem.create!(invoice: @customer5_invoices[0], item: @merchant5_items[0], unit_price: 768, quantity: 8)
    @invoice_item14 = InvoiceItem.create!(invoice: @customer5_invoices[1], item: @merchant5_items[1], unit_price: 8765, quantity: 3)
    @invoice_item15 = InvoiceItem.create!(invoice: @customer5_invoices[4], item: @merchant5_items[7], unit_price: 7645, quantity: 4)
    @invoice_item16 = InvoiceItem.create!(invoice: @customer6_invoices[0], item: @merchant6_items[0], unit_price: 4623, quantity: 4)
    @invoice_item17 = InvoiceItem.create!(invoice: @customer6_invoices[1], item: @merchant6_items[7], unit_price: 6876, quantity: 4)
    @invoice_item18 = InvoiceItem.create!(invoice: @customer7_invoices[0], item: @merchant6_items[8], unit_price: 4265, quantity: 4)
    @invoice_item19 = InvoiceItem.create!(invoice: @customer7_invoices[3], item: @merchant6_items[3], unit_price: 97568, quantity: 4)
    @invoice_item20 = InvoiceItem.create!(invoice: @customer7_invoices[2], item: @merchant7_items[3], unit_price: 3254, quantity: 4)
    @invoice_item21 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
    @invoice_item22 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 9, unit_price: 23324, status: "packaged")
    @invoice_item23 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item24 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item25 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item26 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item27 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item28 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice8.id, quantity: 9, unit_price: 23324, status: "pending")
    create(:transaction, invoice: @customer1_invoices[0], result: "success")
    create(:transaction, invoice: @customer1_invoices[2], result: "failed")
    create(:transaction, invoice: @customer1_invoices[3], result: "success")
    create(:transaction, invoice: @customer1_invoices[1], result: "success")
    create(:transaction, invoice: @customer2_invoices[0], result: "failed")
    create(:transaction, invoice: @customer2_invoices[1], result: "success")
    create(:transaction, invoice: @customer2_invoices[4], result: "success")
    create(:transaction, invoice: @customer3_invoices[0], result: "failed")
    create(:transaction, invoice: @customer3_invoices[2], result: "success")
    create(:transaction, invoice: @customer3_invoices[4], result: "success")
    create(:transaction, invoice: @customer4_invoices[0], result: "failed")
    create(:transaction, invoice: @customer4_invoices[3], result: "success")
    create(:transaction, invoice: @customer5_invoices[0], result: "success")
    create(:transaction, invoice: @customer5_invoices[1], result: "failed")
    create(:transaction, invoice: @customer5_invoices[4], result: "success")
    create(:transaction, invoice: @customer6_invoices[0], result: "failed")
    create(:transaction, invoice: @customer6_invoices[1], result: "success")
    create(:transaction, invoice: @customer7_invoices[0], result: "success")
    create(:transaction, invoice: @customer7_invoices[3], result: "success")
    create(:transaction, invoice: @customer7_invoices[2], result: "failed")
    create(:transaction, invoice: @customer7_invoices[2], result: "success")

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 0)
    @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
  end

  describe "#top_5_customers" do
    it "should return only the top 5 customers with SUCCESSFUL transactions" do
      top_customers = @merchant1.top_5_customers
      expect(top_customers).to eq([@customer1, @customer6, @customer2, @customer3, @customer5])
      expect(top_customers).to_not eq([@customer1, @customer3, @customer2, @customer6, @customer5])
      expect(top_customers).to_not include(@customer4)
    end
  end
  
  describe "#items_ready_to_ship" do
    it "should return only the items that have a status of packaged" do
      expect(@merchant1.items_ready_to_ship).to eq([@item1])
      expect(@merchant1.items_ready_to_ship).to_not eq([@item2])
    end
  end

  it "returns all enabled merchants" do
    expect(Merchant.enabled).to eq([@merchant1, @merchant2, @merchant3, @merchant4])
  end

  it "returns all disabled merchants" do
    expect(Merchant.disabled).to eq([@merchant5, @merchant6, @merchant7])
  end

  it "returns one merchant's total revenue generated" do
    expect(@merchant1.total_revenue).to eq(1477620)
    expect(@merchant2.total_revenue).to eq(165826)
    expect(@merchant3.total_revenue).to eq(6453)
    expect(@merchant4.total_revenue).to eq(54388)
    expect(@merchant5.total_revenue).to eq(36724)
    expect(@merchant6.total_revenue).to eq(434836)
    expect(@merchant7.total_revenue).to eq(13016)
  end

  it "returns formatted total revenue" do
    expect(@merchant1.format_money(:total_revenue)).to eq("$14,776.20")
    expect(@merchant2.format_money(:total_revenue)).to eq("$1,658.26")
    expect(@merchant3.format_money(:total_revenue)).to eq("$64.53")
    expect(@merchant4.format_money(:total_revenue)).to eq("$543.88")
    expect(@merchant5.format_money(:total_revenue)).to eq("$367.24")
    expect(@merchant6.format_money(:total_revenue)).to eq("$4,348.36")
    expect(@merchant7.format_money(:total_revenue)).to eq("$130.16")
  end

  it "returns top 5 merchants by total revenue generated" do
    top_5_array = Merchant.top_5_by_total_revenue
  
    expect(top_5_array).to eq([@merchant1, @merchant6, @merchant2, @merchant4, @merchant5])
  end

  it "returns best day for each merchant (most profitable day)" do
    expect(@merchant1.best_day).to eq("Friday, May 4, 2012")
    expect(@merchant2.best_day).to eq("Tuesday, April 7, 1998")
    expect(@merchant3.best_day).to eq("Friday, July 6, 1900")
    expect(@merchant4.best_day).to eq("Friday, July 6, 1900")
    expect(@merchant5.best_day).to eq("Monday, May 4, 1987")
    expect(@merchant6.best_day).to eq("Sunday, July 6, 2003")
    expect(@merchant7.best_day).to eq("Sunday, July 6, 2003")
  end
end