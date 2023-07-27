require "rails_helper"

RSpec.describe "Admin Merchants Index Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "Targete", enabled: true)
    @merchant3 = Merchant.create!(name: "Fifteen Bears", enabled: true)
    @merchant4 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant5 = Merchant.create!(name: "Freddy Meyers", enabled: false)
    @merchant6 = Merchant.create!(name: "Timmy Hortons", enabled: false)
  end

  # User Story 24
  it "shows the name of each merchant in the system" do
    visit admin_merchants_path
    # save_and_open_page
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
    save_and_open_page
    within(".table-container") do
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
    end

    within("tr#em-#{@merchant1.id}") do
      click_button("Disable Merchant")
    end

    within("tr#dm-#{@merchant5.id}") do
      click_button("Enable Merchant")
    end
    save_and_open_page
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

  #User story 30
  it "has a section for top five merchants by total revenue" do

  end
  # 30. Admin Merchants: Top 5 Merchants by Revenue

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

