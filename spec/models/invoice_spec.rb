require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do 
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    # it { should have_many(:items).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
  end

  before(:each) do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    @merchant1 = Merchant.create!(name: "Safeway")
    @merchant2 = Merchant.create!(name: "Floormart")
    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant2.id)
    @invoice1 = Invoice.create!(status: "in progress", customer_id: customer1.id)
    @invoice2 = Invoice.create!(status: "in progress", customer_id: customer2.id)
    @invoice3 = Invoice.create!(status: "in progress", customer_id: customer3.id)
    @invoice4 = Invoice.create!(status: "in progress", customer_id: customer4.id)
    @invoice5 = Invoice.create!(status: "completed", customer_id: customer5.id)
    @invoice6 = Invoice.create!(status: "completed", customer_id: customer6.id)
    @invoice7 = Invoice.create!(status: "completed", customer_id: customer6.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "packaged")
    invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 9, unit_price: 23324, status: "packaged")
    invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
    invoice_item4 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
    invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item6 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item8 = InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 23324, status: "shipped")
    transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "failed")
    transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
  end

  it "Can return all invoices with unshipped items ordered by oldest to newest" do
    incomplete_invoices = Invoice.incomplete_invoices

    expect(incomplete_invoices.count).to eq(4)
    expect(incomplete_invoices.sample).to be_a(Invoice)
    expect(incomplete_invoices.sample.status).to eq("in progress")
    expect(incomplete_invoices).to eq([@invoice4, @invoice3, @invoice2, @invoice1])
  end

  it "formats invoice dates as Weekday, Month Day, Year" do
    full_date = @invoice1.formatted_date.delete(",")
    date_array = full_date.split
    weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    days = (1..31).to_a
    expect(weekdays).to include(date_array[0])
    expect(months).to include(date_array[1])
    expect(days).to include(date_array[2].to_i)
    expect(date_array[3].length).to eq(4)
  end

  it "calculates total revenue for all items" do
    expect(@invoice1.total_revenue).to eq(161471)
    expect(@invoice2.total_revenue).to eq(209916)
    expect(@invoice6.total_revenue).to eq(419832)
  end

  it "formats the revenue" do
    expect(@invoice1.format_money(@invoice1.total_revenue)).to eq("$1,614.71")
    expect(@invoice2.format_money(@invoice2.total_revenue)).to eq("$2,099.16")
    expect(@invoice6.format_money(@invoice6.total_revenue)).to eq("$4,198.32")
  end

  it "can filter invoice items by merchant" do
    expect(@invoice1.invoice_items_for(@merchant1)).to eq([@invoice_item1])
  end

  it "can filter total_revenue by merchant" do
    expect(@invoice1.revenue_for(@merchant1)).to eq(68175)
  end
end