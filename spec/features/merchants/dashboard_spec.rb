require "rails_helper"

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Homer's Glassware")
    
  end

  describe "as a merchant" do
    it "when I visit my merchant dashboard I see my merchant name" do
      visit merchant_path(@merchant)

      expect(page).to have_content("Welcome #{@merchant.name}")
    end

    it "merchant dashboard items index link" do
      visit merchant_path(@merchant)

      expect(page).to have_link("My Items")
      click_link("My Items")
      expect(current_path).to eq(merchant_items_path(@merchant)) 

    end

    it "merchant dashboard invoices index link" do
      visit merchant_path(@merchant)

      expect(page).to have_link("My Invoices")
      click_link("My Invoices")
      expect(current_path).to eq(merchant_invoices_path(@merchant)) 

    end

  end
end