require "rails_helper"

RSpec.describe "Admin Merchant Create Page" do
  # User story 29
  it "links from the admin merchant index page" do
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant", href: new_admin_merchant_path)
  end

  it "has form to add new merchant info" do
    visit admin_merchants_path

    expect(page).to_not have_content("FloorMart")
    click_link("Create New Merchant")

    expect(page).to have_content("Create New Merchant")
    expect(page).to have_field("Name")
    fill_in("Name", with: "FloorMart")
    
    click_button("Submit")

    expect(current_path).to eq(admin_merchants_path)
    within(".disabled") do
      expect(page).to have_content("FloorMart")
    end

    within(".enabled") do
      expect(page).to_not have_content("FloorMart")
    end
  end

  it "throws an error if name is blank" do
    visit new_admin_merchant_path

    click_button("Submit")

    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_content("Please fill in the name")
  end
end