require "rails_helper"

RSpec.describe "Admin Dashboard Page" do
  # customers = 5.times {FactoryBot.build(:customer)}
  # let!(:customers) {create_list(:customer, 6) }
  # let!(:merchants) {create_list(:merchant, 7)}
  # # let!(:items) {create_list(:item, 20)}
  # # let!(:invoice) {create(:invoice)}
  # # let!(:invoice_item) {create(:invoice_item)}
  # # let!(:transaction) {create(:transaction)}
  # Rake::Task['db:seed'].invoke
  before(:each) do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
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
  end

  # User Story 19
  it "shows I am on the admin dashboard page" do
    visit "/admin"
    # save_and_open_page
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  # User Story 20
  it "has a link to admin merchants and invoices indexes" do
    visit "/admin"
    expect(page).to have_link("Merchants", href: "/admin/merchants")
    expect(page).to have_link("Invoices", href: "/admin/invoices")
  end

  # User Story 21
  it "shows Top Customers statistics" do
    visit "/admin"
    # save_and_open_page
    expect(page).to have_content("Top Customers")
    expect(page).to have_content("Jane Smith: 1 transaction")
    expect(page).to have_content("John Smith: 1 transaction")
    expect(page).to have_content("Janet Smith: 1 transaction")
    expect(page).to have_content("Johnathan Smith: 1 transaction")
    expect(page).to have_content("Johnny Smith: 2 transactions")
    expect(page).to_not have_content("Bob Smith")
    expect("Johnny Smith: 2 transactions").to appear_before("Johnathan Smith: 1 transaction")
    expect("Johnny Smith: 2 transactions").to appear_before("Janet Smith: 1 transaction")
    expect("Johnny Smith: 2 transactions").to appear_before("John Smith: 1 transaction")
    expect("Johnny Smith: 2 transactions").to appear_before("Jane Smith: 1 transaction")
  end

# 21. Admin Dashboard Statistics - Top Customers

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted
end