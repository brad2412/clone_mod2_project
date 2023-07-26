require "rails_helper"

RSpec.describe "Admin Merchants Index Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway")
    @merchant2 = Merchant.create!(name: "Targete")
    @merchant3 = Merchant.create!(name: "Fifteen Bears")
    @merchant4 = Merchant.create!(name: "Queen Soopers")
    @merchant5 = Merchant.create!(name: "Freddy Meyers")
    @merchant6 = Merchant.create!(name: "Timmy Hortons")
  end

  # User Story 24
  it "shows the name of each merchant in the system" do
    visit admin_merchants_path
    save_and_open_page
    expect(page).to have_content("Merchants")
    expect(page).to have_link("Dangerway", href: admin_merchant_path(@merchant1))
    expect(page).to have_link("Targete", href: admin_merchant_path(@merchant2))
    expect(page).to have_link("Fifteen Bears", href: admin_merchant_path(@merchant3))
    expect(page).to have_link("Queen Soopers", href: admin_merchant_path(@merchant4))
    expect(page).to have_link("Freddy Meyers", href: admin_merchant_path(@merchant5))
    expect(page).to have_link("Timmy Hortons", href: admin_merchant_path(@merchant6))
  end
end

