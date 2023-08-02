require "rails_helper"

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")

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
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)

    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: 5.days.ago)
    @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id)
    @invoice8 = Invoice.create!(status: "completed", customer_id: @customer8.id)
    @invoice9 = Invoice.create!(status: "completed", customer_id: @customer8.id, created_at: 3.days.ago)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 13635, status: "pending")
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 9, unit_price: 23324, status: "packaged")
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item4 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item6 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item8 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice8.id, quantity: 9, unit_price: 23324, status: "pending")
    @invoice_item9 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice9.id, quantity: 5, unit_price: 23324, status: "packaged")

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 0)
    @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)
    @transaction9 = Transaction.create!(invoice_id: @invoice9.id, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: 1)

  end

  describe "as a merchant" do
    it "when I visit my merchant dashboard I see my merchant name" do
      visit merchant_path(@merchant1)

      expect(page).to have_content("Welcome #{@merchant1.name}")
    end

    it "has a merchant dashboard items index link" do
      visit merchant_path(@merchant1)

      expect(page).to have_link("My Items")
      click_link("My Items")
      expect(current_path).to eq(merchant_items_path(@merchant1)) 

    end

    it "has a merchant dashboard invoices index link" do
      visit merchant_path(@merchant1)

      expect(page).to have_link("My Invoices")
      click_link("My Invoices")
      expect(current_path).to eq(merchant_invoices_path(@merchant1)) 

    end

    describe "Merchant Dashboard Statistics" do
      it "should show largest number of successful transactions" do
        visit merchant_path(@merchant1)

        within "#top_5_customers" do

          expect(page).to have_content("Johnny Smith Successful Transactions: 4")
          expect(page).to have_content("Smelly Cow Successful Transactions: 4")
          expect(page).to have_content("Jane Smith Successful Transactions: 1")
          expect(page).to have_content("John Smith Successful Transactions: 1")
          expect(page).to have_content("Janet Smith Successful Transactions: 1")
        end
      end
    end

    describe "items_ready_to_ship" do
      it "should show item names that have been ordered but not shipped with invoice id" do
        visit merchant_path(@merchant1)
        # save_and_open_page
        expect(page).to have_content("Items Ready To Ship")
        # save_and_open_page
        within '#items_ready_to_ship' do
          expect(page).to have_content("Item Name: #{@item1.name}")
          expect(page).to have_content("Item Name: #{@item3.name}")
          expect(page).to have_content("Invoice Date: #{@invoice2.formatted_date}")
          expect(page).to have_content("Invoice Date: #{@invoice9.formatted_date}")
          expect(page).to have_link("#{@invoice2.id}")
          expect(page).to have_link("#{@invoice9.id}")
          expect(@invoice2.formatted_date).to appear_before(@invoice9.formatted_date)

          click_link("#{@invoice2.id}")

          expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}")
          
        end

      end
    end
  end

  # User stories 37 and 40
  it "has the logo and likes" do
    visit merchant_path(@merchant1)

    image_src = "https://images.unsplash.com/photo-1666324574241-2f1fe62c490b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODMyOTJ8MHwxfGFsbHx8fHx8fHx8fDE2OTA5NDcxODl8&ixlib=rb-4.0.3&q=80&w=200"
    expect(page.find("#logo")["src"]).to eq(image_src)
    expect(page).to have_content("Likes:")

  end
end


