require "rails_helper"

RSpec.describe "items show page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")
    @merchant2 = Merchant.create!(name: "Spatula City")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id)
  end


  describe "Merchant items show page" do
    it "should show attribues on the merchants items show page" do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content("Name: #{@item1.name}")
      expect(page).to have_content("Description: #{@item1.description}")
      expect(page).to have_content("Current Selling Price: $13.37")
      expect(page).to_not have_content("Name: #{@item2.name}") 
    end

    it "should have a link to update an item's information" do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_link"Update Item"
      click_link"Update Item"
      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end
  end
end

# 8. Merchant Item Update

# As a merchant,
# When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.