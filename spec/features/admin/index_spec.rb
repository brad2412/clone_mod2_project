require "rails_helper"

RSpec.describe "Admin Dashboard Page" do
  before(:each) do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    merchant1 = Merchant.create!(name: "Safeway")
    item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: merchant1.id)
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
    invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "shipped")
    transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "failed")
    transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
  end

  # User Story 19
  it "shows I am on the admin dashboard page" do
    visit admin_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  # User Story 20
  it "has a link to admin merchants and invoices indexes" do
    visit admin_path
    expect(page).to have_link("Merchants", href: admin_merchants_path)
    expect(page).to have_link("Invoices", href: admin_invoices_path)
  end

  # User Story 21
  it "shows Top Customers statistics" do
    visit admin_path

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

  # User story 22
  it "has an incomplete invoices section" do
    visit admin_path

    expect(page).to have_content("Incomplete Invoices")

    
    expect(page).to have_link("Invoice ##{@invoice1.id}", href: admin_invoice_path(@invoice1))
    expect(page).to have_link("Invoice ##{@invoice2.id}", href: admin_invoice_path(@invoice2))
    expect(page).to have_link("Invoice ##{@invoice3.id}", href: admin_invoice_path(@invoice3))
    expect(page).to have_link("Invoice ##{@invoice4.id}", href: admin_invoice_path(@invoice4))
    

    expect(page).to_not have_content("Invoice #{@invoice5.id}")
  end

  # User story 23
  it "lists each incomplete invoice from oldest to newest" do
    visit admin_path

    within("#invoice-#{@invoice1.id}") do
      expect(page).to have_link("Invoice ##{@invoice1.id}")
      expect(page).to have_content(@invoice1.formatted_date)
    end

    within("#invoice-#{@invoice2.id}") do
      expect(page).to have_link("Invoice ##{@invoice2.id}")
      expect(page).to have_content(@invoice2.formatted_date)
    end

    within("#invoice-#{@invoice3.id}") do
      expect(page).to have_link("Invoice ##{@invoice3.id}")
      expect(page).to have_content(@invoice3.formatted_date)
    end

    within("#invoice-#{@invoice4.id}") do
      expect(page).to have_link("Invoice ##{@invoice4.id}")
      expect(page).to have_content(@invoice4.formatted_date)
    end

    expect("Invoice ##{@invoice4.id}").to appear_before("Invoice ##{@invoice3.id}")
    expect("Invoice ##{@invoice3.id}").to appear_before("Invoice ##{@invoice2.id}")
    expect("Invoice ##{@invoice2.id}").to appear_before("Invoice ##{@invoice1.id}")
  end


  it "has the logo at top of page" do
    visit admin_path
    
    expect(page.find("#logo")["src"]).to have_content("something.png")
    #  might be :src ?
    # could potentially also use [:alt] to check alt text of that image to eq(alt text)

  # User stories 37 and 40
  it "has the logo and likes" do
    visit admin_path

    image_src = "https://images.unsplash.com/photo-1666324574241-2f1fe62c490b"
    expect(page.find("#logo")["src"]).to include(image_src)
    expect(page).to have_content("Likes:")

  end
end