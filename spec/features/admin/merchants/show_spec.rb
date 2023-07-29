require "rails_helper"

RSpec.describe "The Admin Merchants Show Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway")
    @merchant2 = Merchant.create!(name: "Targete")
    @merchant3 = Merchant.create!(name: "Fifteen Bears")
    @merchant4 = Merchant.create!(name: "Queen Soopers")
    @merchant5 = Merchant.create!(name: "Freddy Meyers")
    @merchant6 = Merchant.create!(name: "Timmy Hortons")
  end

  # User Story 25
  it "links from admin index merchant links" do
    visit admin_merchants_path
    # save_and_open_page
    click_link "Fifteen Bears"
    # save_and_open_page
    expect(current_path).to eq(admin_merchant_path(@merchant3))
    expect(page).to have_content("Merchant: Fifteen Bears")
  end
end
