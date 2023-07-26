require "rails_helper"

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Homer's Glassware")

    @customer1 = Customers.create!(first_name: "John", last_name: "Wick")
    @customer2 = Customers.create!(first_name: "Barry", last_name: "Bonds")
    @customer3 = Customers.create!(first_name: "Sarah", last_name: "Conner")
    @customer4 = Customers.create!(first_name: "Jennifer", last_name: "Aniston")
    @customer5 = Customers.create!(first_name: "Ricky", last_name: "Bobby")

    
    
  end

  describe "as a merchant" do
    it "when I visit my merchant dashboard I see my merchant name" do
      visit merchant_path(@merchant)

      expect(page).to have_content("Welcome #{@merchant.name}")
    end

    it "has a merchant dashboard items index link" do
      visit merchant_path(@merchant)

      expect(page).to have_link("My Items")
      click_link("My Items")
      expect(current_path).to eq(merchant_items_path(@merchant)) 

    end

    it "has a merchant dashboard invoices index link" do
      visit merchant_path(@merchant)

      expect(page).to have_link("My Invoices")
      click_link("My Invoices")
      expect(current_path).to eq(merchant_invoices_path(@merchant)) 

    end

    describe "Merchant Dashboard Statistics" do
      it "should show largest number of successful transactions" do
        visit merchant_path(@merchant)

        expect(page).to have_content(1-5)
        expect(page).to have_content(1-5)
        expect(page).to have_content(1-5)
        expect(page).to have_content(1-5)
        expect(page).to have_content(1-5)

        expect(page).to appear_before(1-5)
      end
    end

  end
end

# 3. Merchant Dashboard Statistics - Favorite Customers

# As a merchant,
# When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant