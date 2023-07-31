require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices}
    it { should have_many(:transactions).through(:invoices) }
    # it { should have_many(:merchants).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe "#total_transactions" do
    it "counts total transactions by customer" do
      customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
      customer3 = Customer.create!(first_name: "John", last_name: "Smith")
      customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
      customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
      customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
      customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
      merchant1 = Merchant.create!(name: "Safeway")
      item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: merchant1.id)
      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "completed", customer_id: customer2.id)
      invoice3 = Invoice.create!(status: "completed", customer_id: customer3.id)
      invoice4 = Invoice.create!(status: "completed", customer_id: customer4.id)
      invoice5 = Invoice.create!(status: "completed", customer_id: customer5.id)
      invoice6 = Invoice.create!(status: "completed", customer_id: customer6.id)
      invoice7 = Invoice.create!(status: "completed", customer_id: customer6.id)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
      invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item4 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item5 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice5.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item6 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "failed")
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")


      expect(customer1.total_transactions).to eq(0)
      expect(customer2.total_transactions).to eq(1)
      expect(customer3.total_transactions).to eq(1)
      expect(customer4.total_transactions).to eq(1)
      expect(customer5.total_transactions).to eq(1)
      expect(customer6.total_transactions).to eq(2)
      expect(customer7.total_transactions).to eq(0)
    end
  end

  describe "#self.top_customers" do
    it "returns top five customers with most transactions" do
      customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
      customer3 = Customer.create!(first_name: "John", last_name: "Smith")
      customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
      customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
      customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
      customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
      merchant1 = Merchant.create!(name: "Safeway")
      item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: merchant1.id)
      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "completed", customer_id: customer2.id)
      invoice3 = Invoice.create!(status: "completed", customer_id: customer3.id)
      invoice4 = Invoice.create!(status: "completed", customer_id: customer4.id)
      invoice5 = Invoice.create!(status: "completed", customer_id: customer5.id)
      invoice6 = Invoice.create!(status: "completed", customer_id: customer6.id)
      invoice7 = Invoice.create!(status: "completed", customer_id: customer6.id)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
      invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item4 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item5 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice5.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item6 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")


      top_customers = Customer.top_customers.map(&:id)
      # binding.pry
      expect(top_customers.count).to eq(5)
      expect(top_customers).to eq([customer6.id, customer1.id, customer2.id, customer3.id, customer4.id])
    end
  end

  describe "#full_name" do
    it "returns the first and last name of customer" do
      customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")

      expect(customer1.full_name).to eq("Bob Smith")
      expect(customer2.full_name).to eq("Jane Smith")
    end
  end
end