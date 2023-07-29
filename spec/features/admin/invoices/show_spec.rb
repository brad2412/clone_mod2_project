require "rails_helper"

RSpec.describe "Admin Invoices show page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant1.id)

    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")

    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    
    @invoice_item1 = InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 5, unit_price: 3476, status: "pending")
    @invoice_item2 = InvoiceItem.create!(invoice: @invoice1, item: @item2, quantity: 4, unit_price: 802, status: "packaged")
    @invoice_item3 = InvoiceItem.create!(invoice: @invoice1, item: @item3, quantity: 465, unit_price: 754, status: "shipped")
    @invoice_item4 = InvoiceItem.create!(invoice: @invoice1, item: @item4, quantity: 23, unit_price: 1509, status: "shipped")
  end

  #User story 33
  it "should display the invoice's id, status, date created, and customer's name" do
    visit admin_invoice_path(@invoice1)

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Status:")
    expect(page).to have_content("#{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.formatted_date}")
    expect(page).to have_content("Customer: Bob Smith")
  end

  #User story 34
  it "shows the list of items that are part of this invoice" do
    visit admin_invoice_path(@invoice1)

    expect(page).to have_content("Items on this order:")

    within("#item-#{@item1.id}") do
      expect(page).to have_content("Item: cheese")
      expect(page).to have_content("Quantity Ordered: 5")
      expect(page).to have_content("Sold at: $34.76 per unit")
      expect(page).to have_content("Item Status: pending")
    end

    within("#item-#{@item2.id}") do
      expect(page).to have_content("Item: bad cheese")
      expect(page).to have_content("Quantity Ordered: 4")
      expect(page).to have_content("Sold at: $8.02 per unit")
      expect(page).to have_content("Item Status: packaged")
    end

    within("#item-#{@item3.id}") do
      expect(page).to have_content("Item: Bacon")
      expect(page).to have_content("Quantity Ordered: 465")
      expect(page).to have_content("Sold at: $7.54 per unit")
      expect(page).to have_content("Item Status: shipped")
    end

    within("#item-#{@item4.id}") do
      expect(page).to have_content("Item: Chowda")
      expect(page).to have_content("Quantity Ordered: 23")
      expect(page).to have_content("Sold at: $15.09 per unit")
      expect(page).to have_content("Item Status: shipped")
    end
  end

  #User story 35
  it "displays the total revenue for the whole invoice" do
    visit admin_invoice_path(@invoice1)

    expect(page).to have_content("Total For This Invoice: $4,059.05")
  end

  #User story 36
  it "can update the invoice status" do
    visit admin_invoice_path(@invoice1)

    expect(page).to have_select(:status, with_options: ["in progress", "cancelled", "completed"], selected: "completed")
    expect(page).to have_button("Update Invoice Status")

    select("in progress", from: :status)
    click_button("Update Invoice Status")

    expect(current_path).to eq(admin_invoice_path(@invoice1))
    expect(page).to have_select(:status, selected: "in progress")
  end
end