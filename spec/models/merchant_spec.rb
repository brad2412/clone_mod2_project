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
    @customer1_invoices = create_list(:invoice, 5, customer: @customer1)
    @customer2_invoices = create_list(:invoice, 5, customer: @customer2)
    @customer3_invoices = create_list(:invoice, 5, customer: @customer3)
    @customer4_invoices = create_list(:invoice, 5, customer: @customer4)
    @customer5_invoices = create_list(:invoice, 5, customer: @customer5)
    @customer6_invoices = create_list(:invoice, 5, customer: @customer6)
    @customer7_invoices = create_list(:invoice, 5, customer: @customer7)
    @invoice1 = InvoiceItem.create!(invoice: @customer1_invoices[0], item: @merchant1_items[0], unit_price: 423, quantity: 4)
    @invoice2 = InvoiceItem.create!(invoice: @customer1_invoices[2], item: @merchant1_items[4], unit_price: 5463, quantity: 6)
    @invoice3 = InvoiceItem.create!(invoice: @customer1_invoices[3], item: @merchant1_items[5], unit_price: 543, quantity: 9)
    @invoice4 = InvoiceItem.create!(invoice: @customer1_invoices[1], item: @merchant1_items[6], unit_price: 543, quantity: 3)
    @invoice5 = InvoiceItem.create!(invoice: @customer2_invoices[0], item: @merchant1_items[6], unit_price: 54, quantity: 8)
    @invoice6 = InvoiceItem.create!(invoice: @customer2_invoices[1], item: @merchant2_items[0], unit_price: 7465, quantity: 4)
    @invoice7 = InvoiceItem.create!(invoice: @customer2_invoices[4], item: @merchant2_items[3], unit_price: 45322, quantity: 3)
    @invoice8 = InvoiceItem.create!(invoice: @customer3_invoices[0], item: @merchant3_items[0], unit_price: 76556, quantity: 2)
    @invoice9 = InvoiceItem.create!(invoice: @customer3_invoices[2], item: @merchant3_items[3], unit_price: 6453, quantity: 1)
    @invoice10 = InvoiceItem.create!(invoice: @customer3_invoices[4], item: @merchant4_items[7], unit_price: 4532, quantity: 8)
    @invoice11 = InvoiceItem.create!(invoice: @customer4_invoices[0], item: @merchant4_items[7], unit_price: 9876, quantity: 4)
    @invoice12 = InvoiceItem.create!(invoice: @customer4_invoices[3], item: @merchant4_items[9], unit_price: 4533, quantity: 4)
    @invoice13 = InvoiceItem.create!(invoice: @customer5_invoices[0], item: @merchant5_items[0], unit_price: 768, quantity: 8)
    @invoice14 = InvoiceItem.create!(invoice: @customer5_invoices[1], item: @merchant5_items[1], unit_price: 8765, quantity: 3)
    @invoice15 = InvoiceItem.create!(invoice: @customer5_invoices[4], item: @merchant5_items[7], unit_price: 7645, quantity: 4)
    @invoice16 = InvoiceItem.create!(invoice: @customer6_invoices[0], item: @merchant6_items[0], unit_price: 4623, quantity: 4)
    @invoice17 = InvoiceItem.create!(invoice: @customer6_invoices[1], item: @merchant6_items[7], unit_price: 6876, quantity: 4)
    @invoice18 = InvoiceItem.create!(invoice: @customer7_invoices[0], item: @merchant6_items[8], unit_price: 4265, quantity: 4)
    @invoice19 = InvoiceItem.create!(invoice: @customer7_invoices[3], item: @merchant6_items[3], unit_price: 97568, quantity: 4)
    @invoice20 = InvoiceItem.create!(invoice: @customer7_invoices[2], item: @merchant7_items[3], unit_price: 3254, quantity: 4)
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
  end

  describe "#top_5_customers" do
    it "should return only the top 5 customers with SUCCESSFUL transactions" do
      top_customers = @merchant1.top_5_customers
      expect(top_customers).to eq([@customer6, @customer2, @customer3, @customer4, @customer5])
      expect(top_customers).to_not eq(@customer1)
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
    expect(@merchant1.total_revenue).to eq(8208)
    expect(@merchant2.total_revenue).to eq(165826)
    expect(@merchant3.total_revenue).to eq(6453)
    expect(@merchant4.total_revenue).to eq(54388)
    expect(@merchant5.total_revenue).to eq(36724)
    expect(@merchant6.total_revenue).to eq(434836)
    expect(@merchant7.total_revenue).to eq(13016)
      
      # Throw in the calculation here? Like items X invoices and make sure it equals method
  end

  it "returns top 5 merchants by total revenue generated" do
  #   top_5_array = Merchant.top_5_by_total_revenue
  #   expect(top_5_array).to be_a(Array)
  #   expect(top_5_array.count).to eq(5)
  #   expect(top_5_array[0].)
  # expect 6, 2, 4, 5, 7
  end

#   We were playing around with this in my check-ins today so figured I would share it with everyone! Syntax for creating multiple test objects using FactoryBot that share the same trait (i.e. an association).
# create_list(:name_of_factory, num_of_objects, trait)
# Example: Creating multiple invoices for a given customer (@customer )
# invoices_for_customer_1 = create_list(:invoice, 5, customer: @customer)
# This will create 5 invoices for a customer1
  # As an admin,
  # When I visit the admin merchants index (/admin/merchants)
  # Then I see the names of the top 5 merchants by total revenue generated
  # And I see that each merchant name links to the admin merchant show page for that merchant
  # And I see the total revenue generated next to each merchant name
  

  # Notes on Revenue Calculation:
  # - Only invoices with at least one successful transaction should count towards revenue
  # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price) 
end