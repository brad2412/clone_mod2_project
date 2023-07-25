require "rails_helper"

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant = Merchant.create!(name: "Homer's Glassware")
    
  end

#   As a merchant,
# When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
# Then I see the name of my merchant

  describe "as a merchant" do
    it "when I visit my merchant ddashboard I see my merchant name" do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("Welcome #{@merchant.name}")
    end
  end
end