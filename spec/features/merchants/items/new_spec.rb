require "rails_helper"

RSpec.describe "merchant item create page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")
  end

  it "creates a new item" do
    visit merchant_items_path(@merchant1)
    click_link "New Item"
    expect(current_path).to eq(new_merchant_item_path(@merchant1))
    expect(page).to have_content("Create New Item")

    expect(page).to have_field("Name")
    fill_in("Name", with: "Eggs")
    expect(page).to have_field("Description")
    fill_in("Description", with: "Extra Tasty")
    expect(page).to have_field("Unit price")
    fill_in("Unit price", with: "733")
    click_button("Submit")
    expect(current_path).to eq(merchant_items_path(@merchant1))

    within(".disabled") do
      expect(page).to have_content("Eggs")
    end
  end
  it "displays a flash message 'Please fill in all fields' when data entry is invalid" do
    visit merchant_items_path(@merchant1)
    click_link "New Item"

    fill_in("Name", with: "")
    fill_in("Description", with: "")
    fill_in("Unit price", with: "")
    click_button('Submit')

    expect(current_path).to eq(new_merchant_item_path(@merchant1))
    expect(page).to have_text("Please fill in all fields")
  end


end