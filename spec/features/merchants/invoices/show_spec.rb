require "rails_helper"

RSpec.describe "Merchants Invoice Show Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "FloorMart", enabled: true)

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant1.id)
    @item5 = Item.create!(name: "Not Bacon", description: "idk man", unit_price: 4635, merchant: @merchant2)

    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")

    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    
    @invoice_item1 = InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 5, unit_price: 3476, status: "pending")
    @invoice_item2 = InvoiceItem.create!(invoice: @invoice1, item: @item2, quantity: 4, unit_price: 802, status: "packaged")
    @invoice_item3 = InvoiceItem.create!(invoice: @invoice1, item: @item3, quantity: 465, unit_price: 754, status: "shipped")
    @invoice_item4 = InvoiceItem.create!(invoice: @invoice1, item: @item4, quantity: 23, unit_price: 1509, status: "shipped")
    @invoice_item5 = InvoiceItem.create!(invoice: @invoice1, item: @item5, quantity: 12, unit_price: 21342, status: "pending")
  end

  # User Story 15
  it "has all details of that specific invoice" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Status: completed")
    expect(page).to have_content("Created on: #{@invoice1.formatted_date}")
    expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
  end

  # User Story 16
  it "shows all items on the invoice and their details" do
    visit merchant_invoice_path(@merchant1, @invoice1)

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

    expect(page).to_not have_content("Not Bacon")
  end

  # User Story 17
  xit "" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see the total revenue that will be generated from all of my items on the invoice
  end

  # User Story 18
  xit "" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated
  end
end