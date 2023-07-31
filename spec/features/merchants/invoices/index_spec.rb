require "rails_helper"

RSpec.describe "Merchants Invoice Index Page" do
  before(:each) do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    @merchant1 = Merchant.create!(name: "Dangerway")
    @merchant2 = Merchant.create!(name: "FloorMart")
    item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant2.id)
    @invoice1 = Invoice.create!(status: "in progress", customer_id: customer1.id)
    @invoice2 = Invoice.create!(status: "in progress", customer_id: customer2.id)
    @invoice3 = Invoice.create!(status: "in progress", customer_id: customer3.id)
    @invoice4 = Invoice.create!(status: "in progress", customer_id: customer4.id)
    @invoice5 = Invoice.create!(status: "completed", customer_id: customer5.id)
    @invoice6 = Invoice.create!(status: "completed", customer_id: customer6.id)
    @invoice7 = Invoice.create!(status: "completed", customer_id: customer6.id)
    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "packaged")
    invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice2.id, quantity: 9, unit_price: 23324, status: "packaged")
    invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
    invoice_item4 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
    invoice_item5 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice5.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item6 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item7 = InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "shipped")
    invoice_item8 = InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice7.id, quantity: 9, unit_price: 23324, status: "shipped")
  end
  
  # User Story 14
  it "has all invoices with an item sold by this merchant" do
    visit merchant_invoices_path(@merchant1)

    expect(page).to have_content("#{@merchant1.name}'s Invoices")
    expect(page).to have_link("Invoice ##{@invoice1.id}", href: merchant_invoice_path(@merchant1, @invoice1))
    expect(page).to have_link("Invoice ##{@invoice2.id}", href: merchant_invoice_path(@merchant1, @invoice2))
    expect(page).to have_link("Invoice ##{@invoice3.id}", href: merchant_invoice_path(@merchant1, @invoice3))
    expect(page).to have_link("Invoice ##{@invoice4.id}", href: merchant_invoice_path(@merchant1, @invoice4))
    expect(page).to have_link("Invoice ##{@invoice5.id}", href: merchant_invoice_path(@merchant1, @invoice5))
    expect(page).to have_link("Invoice ##{@invoice6.id}", href: merchant_invoice_path(@merchant1, @invoice6))
    expect(page).to_not have_link("Invoice ##{@invoice7.id}")
  end

  it "invoice links go to invoice show page" do
    visit merchant_invoices_path(@merchant1)

    click_link("Invoice ##{@invoice1.id}")

    expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
  end

end