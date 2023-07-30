require "rails_helper"

RSpec.describe "items edit page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")
    @merchant2 = Merchant.create!(name: "Spatula City")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its bad cheese.", unit_price: 1347, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id)
  end

  describe "item edit page functions" do
    it "existing item attribue info with an option to edit" do
      visit edit_merchant_item_path(@merchant1, @item1)

      expect(page).to have_content("Update Name: cheese")
      expect(page).to have_content("Description: its cheese.")
      expect(page).to have_content("Current Selling Price: $13.37")

      expect(page).to_not have_content("Update Name: bad cheese")

      expect(page).to have_field("Name", with: "cheese")
      fill_in("Name", with: "cheeese")
      expect(page).to have_field("Description", with: "its cheese.")
      expect(page).to have_field("Unit Price", with: "$13.37")
      click_button "Submit"

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content("cheeese")
      expect(page).to_not have_content("cheese")
    end
  end
end