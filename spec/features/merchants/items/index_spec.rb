require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "Targete", enabled: true)
    @merchant3 = Merchant.create!(name: "Fifteen Bears", enabled: true)
    @merchant4 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant5 = Merchant.create!(name: "Freddy Meyers", enabled: false)
    @merchant6 = Merchant.create!(name: "Timmy Hortons", enabled: false)
    @merchant7 = Merchant.create!(name: "ZaZa", enabled: false)

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id, enabled: false)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id, enabled: false)
    @item5 = Item.create!(name: "Poo tay toe", description: "spuds", unit_price: 5678, merchant_id: @merchant1.id, enabled: false)
    @item6 = Item.create!(name: "burrito", description: "spicey", unit_price: 8765, merchant_id: @merchant1.id, enabled: false)

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

    @invoice1 = Invoice.create!(status: "completed", customer: @customer1, created_at: Time.new(2011,4,5))
    @invoice2 = Invoice.create!(status: "completed", customer: @customer2, created_at: Time.new(2012,3,4))
    @invoice3 = Invoice.create!(status: "completed", customer: @customer3, created_at: Time.new(2000,5,6))
    @invoice4 = Invoice.create!(status: "completed", customer: @customer4, created_at: Time.new(1999,5,6))
    @invoice5 = Invoice.create!(status: "completed", customer: @customer5, created_at: Time.new(2030,5,4))
    @invoice6 = Invoice.create!(status: "completed", customer: @customer6, created_at: Time.new(2012,5,4))
    @invoice7 = Invoice.create!(status: "completed", customer: @customer6, created_at: Time.new(2016,7,6))
    @invoice8 = Invoice.create!(status: "completed", customer: @customer8, created_at: Time.new(2015,5,3))

    invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 5, unit_price: 13635, status: "packaged")
    invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 9, unit_price: 234324, status: "packaged")
    invoice_item3 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 9, unit_price: 2324, status: "pending")
    invoice_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 9, unit_price: 13394, status: "pending")
    invoice_item5 = InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 9, unit_price: 2324, status: "shipped")
    invoice_item5 = InvoiceItem.create!(item: @item1, invoice: @invoice5, quantity: 9, unit_price: 2324, status: "shipped")
    invoice_item6 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 9, unit_price: 3324, status: "shipped")
    invoice_item7 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 9, unit_price: 235324, status: "shipped")

    transaction1 = Transaction.create!(invoice: @invoice1, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "failed")
    transaction2 = Transaction.create!(invoice: @invoice2, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction3 = Transaction.create!(invoice: @invoice3, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction4 = Transaction.create!(invoice: @invoice4, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction5 = Transaction.create!(invoice: @invoice5, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction6 = Transaction.create!(invoice: @invoice6, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
    transaction7 = Transaction.create!(invoice: @invoice7, credit_card_number: "1234567890987654", credit_card_expiration_date: "04/27", result: "success")
  end

  describe "merchant items index page" do
    it "should list the names of the merchant items" do
      visit merchant_items_path(@merchant1)
      
      expect(page).to have_content("Your Items")
      expect(page).to have_content("cheese")
      expect(page).to have_content("bad cheese")
      expect(page).to have_content("Bacon")
      expect(page).to_not have_content("Name: Chowda")
    end
    
    it "should show all items as links to thats item's show page" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link("#{@item1.name}")
      expect(page).to have_link("#{@item2.name}")
      expect(page).to have_link("#{@item3.name}")
      expect(page).to_not have_link("#{@item4.name}")

      within("tr#ei-#{@item1.id}") do
        click_link ("#{@item1.name}")
      end
      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    end

    # User Story 9
    it "should have a button to disable or enable next to item name" do
      visit merchant_items_path(@merchant1)

      within("tr#ei-#{@item1.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Item")
      end

      within("tr#ei-#{@item2.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Item")
      end

      within("tr#di-#{@item3.id}") do
        expect(page).to have_content("Disabled")
        expect(page).to_not have_content("Enabled")
        expect(page).to have_button("Enable Item")
      end

    end

    # User Story 10
    it "should have enabled and disabled sections that update" do
      visit merchant_items_path(@merchant1)

      within(".enabled") do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("cheese")
        expect(page).to have_content("bad cheese")
        expect(page).to_not have_content("Bacon")
      end

      within(".disabled") do
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content("Bacon")
        expect(page).to_not have_content("cheese")
      end
      
      within("tr#ei-#{@item2.id}") do
        click_button("Disable Item")
      end
      
      within("tr#di-#{@item3.id}") do
        click_button("Enable Item")
      end


      within(".enabled") do
        expect(page).to have_content("cheese")
        expect(page).to_not have_content("bad cheese")
        expect(page).to have_content("Bacon")
      end

      within(".disabled") do
        expect(page).to_not have_content("Bacon")
        expect(page).to have_content("bad cheese")
      end
    end

    # User Story 11
    it "displays a link to create a new item that takes me to a form for item creation" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link("New Item")

      click_link("New Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant1, @item))
    end

    # User Story 12 & 13
    it "should display top 5 most popular items with total revenue generated" do
      visit merchant_items_path(@merchant1)
    
      expect(page).to have_content("Top Five Items By Total Revenue")
      # save_and_open_page
      within("#top_five_items") do
        expect(page).to have_link("burrito")
        expect(page).to have_content("burrito - Total Revenue: $21,478.32")
        expect(page).to have_content("Top selling date for burrito was Friday, May 4, 2012")
        
        expect("burrito").to appear_before("bad cheese")
        
        expect("bad cheese").to appear_before("cheese")

        expect("cheese").to appear_before("Bacon")

        expect("Bacon").to appear_before("Poo tay toe")
      end
    end
  end
end