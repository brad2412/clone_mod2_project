require "rails_helper"

RSpec.describe "The Admin Merchants Edit Page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway")
    @merchant2 = Merchant.create!(name: "Targete")
    @merchant3 = Merchant.create!(name: "Fifteen Bears")
    @merchant4 = Merchant.create!(name: "Queen Soopers")
    @merchant5 = Merchant.create!(name: "Freddy Meyers")
    @merchant6 = Merchant.create!(name: "Timmy Hortons")
  end

  # User story 26
  it "Links from the admin show page" do
    visit admin_merchant_path(@merchant4)
    # save_and_open_page
    click_link "Edit Queen Soopers"
    # save_and_open_page
    expect(current_path).to eq(edit_admin_merchant_path(@merchant4))
  end

  # User story 26.continued
  it "has a prepopulated form to edit this merchant" do
    visit edit_admin_merchant_path(@merchant4)
    # save_and_open_page
    expect(page).to have_content("Update Merchant: Queen Soopers")
    expect(page).to have_field("Name", with: "Queen Soopers")
    click_button "Submit"
    save_and_open_page
    expect(current_path).to eq(admin_merchant_path(@merchant4))
    expect(page).to have_content("Merchant was successfully updated")
    expect(page).to have_content("Queen Soopers")
  end
end