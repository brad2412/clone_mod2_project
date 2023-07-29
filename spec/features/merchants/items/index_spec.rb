require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")
    @merchant2 = Merchant.create!(name: "Spatula City")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id)
  end

  describe "merchant items index page" do
    it "should list the names of the merchant items" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content("Your Items")
      expect(page).to have_content("Name: cheese")
      expect(page).to have_content("Name: bad cheese")
      expect(page).to have_content("Name: Bacon")
      expect(page).to_not have_content("Name: Chowda")
    end
  end

end

# 6. Merchant Items Index Page
# As a merchant,
# When I visit my merchant items index page (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant