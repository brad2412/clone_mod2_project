require "rails_helper"

RSpec.describe "Admin Merchants Index Page" do
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
    @customer8 = Customer.create!(first_name: "Smelly", last_name: "Cow")

    @customer1_invoices = create_list(:invoice, 5, customer: @customer1, created_at: Time.new(2014,6,5))
    @customer2_invoices = create_list(:invoice, 5, customer: @customer2, created_at: Time.new(1998,4,7))
    @customer3_invoices = create_list(:invoice, 5, customer: @customer3, created_at: Time.new(1900,7,6))
    @customer4_invoices = create_list(:invoice, 5, customer: @customer4, created_at: Time.new(1997,7,6))
    @customer5_invoices = create_list(:invoice, 5, customer: @customer5, created_at: Time.new(1987,5,4))
    @customer6_invoices = create_list(:invoice, 5, customer: @customer6, created_at: Time.new(2001,6,5))
    @customer7_invoices = create_list(:invoice, 5, customer: @customer7, created_at: Time.new(2003,7,6))
    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: Time.new(2012,3,4))
    @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id, created_at: Time.new(2000,5,6))
    @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id, created_at: Time.new(1999,5,6))
    @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id, created_at: Time.new(2030,5,4))
    @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2012,5,4))
    @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2016,7,6))
    @invoice8 = Invoice.create!(status: "completed", customer_id: @customer8.id, created_at: Time.new(2015,5,3))




    @invoice_item1 = InvoiceItem.create!(invoice: @customer1_invoices[0], item: @merchant1_items[0], unit_price: 423, quantity: 4)
    @invoice_item2 = InvoiceItem.create!(invoice: @customer1_invoices[2], item: @merchant1_items[4], unit_price: 5463, quantity: 6)
    @invoice_item3 = InvoiceItem.create!(invoice: @customer1_invoices[3], item: @merchant1_items[5], unit_price: 543, quantity: 9)
    @invoice_item4 = InvoiceItem.create!(invoice: @customer1_invoices[1], item: @merchant1_items[6], unit_price: 543, quantity: 3)
    @invoice_item5 = InvoiceItem.create!(invoice: @customer2_invoices[0], item: @merchant1_items[6], unit_price: 54, quantity: 8)
    @invoice_item6 = InvoiceItem.create!(invoice: @customer2_invoices[1], item: @merchant2_items[0], unit_price: 7465, quantity: 4)
    @invoice_item7 = InvoiceItem.create!(invoice: @customer2_invoices[4], item: @merchant2_items[3], unit_price: 45322, quantity: 3)
    @invoice_item8 = InvoiceItem.create!(invoice: @customer3_invoices[0], item: @merchant3_items[0], unit_price: 76556, quantity: 2)
    @invoice_item9 = InvoiceItem.create!(invoice: @customer3_invoices[2], item: @merchant3_items[3], unit_price: 6453, quantity: 1)
    @invoice_item10 = InvoiceItem.create!(invoice: @customer3_invoices[4], item: @merchant4_items[7], unit_price: 4532, quantity: 8)
    @invoice_item11 = InvoiceItem.create!(invoice: @customer4_invoices[0], item: @merchant4_items[7], unit_price: 9876, quantity: 4)
    @invoice_item12 = InvoiceItem.create!(invoice: @customer4_invoices[3], item: @merchant4_items[9], unit_price: 4533, quantity: 4)
    @invoice_item13 = InvoiceItem.create!(invoice: @customer5_invoices[0], item: @merchant5_items[0], unit_price: 768, quantity: 8)
    @invoice_item14 = InvoiceItem.create!(invoice: @customer5_invoices[1], item: @merchant5_items[1], unit_price: 8765, quantity: 3)
    @invoice_item15 = InvoiceItem.create!(invoice: @customer5_invoices[4], item: @merchant5_items[7], unit_price: 7645, quantity: 4)
    @invoice_item16 = InvoiceItem.create!(invoice: @customer6_invoices[0], item: @merchant6_items[0], unit_price: 4623, quantity: 4)
    @invoice_item17 = InvoiceItem.create!(invoice: @customer6_invoices[1], item: @merchant6_items[7], unit_price: 6876, quantity: 4)
    @invoice_item18 = InvoiceItem.create!(invoice: @customer7_invoices[0], item: @merchant6_items[8], unit_price: 4265, quantity: 4)
    @invoice_item19 = InvoiceItem.create!(invoice: @customer7_invoices[3], item: @merchant6_items[3], unit_price: 97568, quantity: 4)
    @invoice_item20 = InvoiceItem.create!(invoice: @customer7_invoices[2], item: @merchant7_items[3], unit_price: 3254, quantity: 4)
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

  # User Story 24
  it "shows the name of each merchant in the system" do
    visit admin_merchants_path

    expect(page).to have_content("Merchants")
    expect(page).to have_link("Dangerway", href: admin_merchant_path(@merchant1))
    expect(page).to have_link("Targete", href: admin_merchant_path(@merchant2))
    expect(page).to have_link("Fifteen Bears", href: admin_merchant_path(@merchant3))
    expect(page).to have_link("Queen Soopers", href: admin_merchant_path(@merchant4))
    expect(page).to have_link("Freddy Meyers", href: admin_merchant_path(@merchant5))
    expect(page).to have_link("Timmy Hortons", href: admin_merchant_path(@merchant6))
  end

  # User story 27
  it "has buttons to disable or enable each merchant" do
    visit admin_merchants_path

    within("tr#em-#{@merchant1.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to_not have_content("Disabled")
      expect(page).to have_button("Disable Merchant")
    end

    within("tr#em-#{@merchant2.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to_not have_content("Disabled")
      expect(page).to have_button("Disable Merchant")
    end

    within("tr#em-#{@merchant3.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to_not have_content("Disabled")
      expect(page).to have_button("Disable Merchant")
    end

    within("tr#em-#{@merchant4.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to_not have_content("Disabled")
      expect(page).to have_button("Disable Merchant")
    end

    within("tr#dm-#{@merchant5.id}") do
      expect(page).to have_content("Disabled")
      expect(page).to_not have_content("Enabled")
      expect(page).to have_button("Enable Merchant")
    end

    within("tr#dm-#{@merchant6.id}") do
      expect(page).to have_content("Disabled")
      expect(page).to_not have_content("Enabled")
      expect(page).to have_button("Enable Merchant")
    end
  end

  # User story 27 continued/story 28
  it "can enable or disable merchants" do
    visit admin_merchants_path

    within(".enabled") do
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Dangerway")
      expect(page).to have_content("Targete")
      expect(page).to have_content("Fifteen Bears")
      expect(page).to have_content("Queen Soopers")
    end
    
    within(".disabled") do
      expect(page).to have_content("Disabled Merchants")
      expect(page).to have_content("Freddy Meyers")
      expect(page).to have_content("Timmy Hortons")
    end

    within("tr#em-#{@merchant1.id}") do
      click_button("Disable Merchant")
    end

    within("tr#dm-#{@merchant5.id}") do
      click_button("Enable Merchant")
    end

    within(".enabled") do
      expect(page).to_not have_content("Dangerway")
      expect(page).to have_content("Targete")
      expect(page).to have_content("Fifteen Bears")
      expect(page).to have_content("Queen Soopers")
      expect(page).to have_content("Freddy Meyers")
    end

    within(".disabled") do
      expect(page).to_not have_content("Freddy Meyers")
      expect(page).to have_content("Timmy Hortons")
      expect(page).to have_content("Dangerway")
    end
  end

  # User story 30
  it "has a section for top five merchants by total revenue" do
    visit admin_merchants_path
    
    expect(page).to have_content("Top Five Merchants By Total Revenue")

    within("#top_five") do
      within("#merchant-#{@merchant6.id}") do
        expect(page).to have_link("#{@merchant6.name}", href: admin_merchant_path(@merchant6))
        expect(page).to have_content("Total Revenue: #{@merchant6.format_money(@merchant6.total_revenue)}")
      end

      within("#merchant-#{@merchant2.id}") do
        expect(page).to have_link("#{@merchant2.name}", href: admin_merchant_path(@merchant2))
        expect(page).to have_content("Total Revenue: #{@merchant2.format_money(@merchant2.total_revenue)}")
      end

      within("#merchant-#{@merchant4.id}") do
        expect(page).to have_link("#{@merchant4.name}", href: admin_merchant_path(@merchant4))
        expect(page).to have_content("Total Revenue: #{@merchant4.format_money(@merchant4.total_revenue)}")
      end 

      within("#merchant-#{@merchant5.id}") do
        expect(page).to have_link("#{@merchant5.name}", href: admin_merchant_path(@merchant5))
        expect(page).to have_content("Total Revenue: #{@merchant5.format_money(@merchant5.total_revenue)}")
      end
      
      within("#merchant-#{@merchant7.id}") do
        expect(page).to have_link("#{@merchant7.name}", href: admin_merchant_path(@merchant7))
        expect(page).to have_content("Total Revenue: #{@merchant7.format_money(@merchant7.total_revenue)}")
      end

      expect(@merchant6.name).to appear_before(@merchant2.name)
      expect(@merchant2.name).to appear_before(@merchant4.name)
      expect(@merchant4.name).to appear_before(@merchant5.name)
      expect(@merchant5.name).to appear_before(@merchant7.name)
    end
  end

  # User story 31
  it "lists the most profitable date for each of top five merchants" do
    visit admin_merchants_path
    
    expect(page).to have_content("Top Five Merchants By Total Revenue")

    within("#top_five") do
      within("#merchant-#{@merchant6.id}") do
        expect(page).to have_content("Top selling date for #{@merchant6.name} was #{@merchant6.best_day}")
      end
      
      within("#merchant-#{@merchant2.id}") do
        expect(page).to have_content("Top selling date for #{@merchant2.name} was #{@merchant2.best_day}")
      end
      
      within("#merchant-#{@merchant4.id}") do
        expect(page).to have_content("Top selling date for #{@merchant4.name} was #{@merchant4.best_day}")
      end 
      
      within("#merchant-#{@merchant5.id}") do
        expect(page).to have_content("Top selling date for #{@merchant5.name} was #{@merchant5.best_day}")
      end
      
      within("#merchant-#{@merchant7.id}") do
        expect(page).to have_content("Top selling date for #{@merchant7.name} was #{@merchant7.best_day}")
      end
    end
  end
end

