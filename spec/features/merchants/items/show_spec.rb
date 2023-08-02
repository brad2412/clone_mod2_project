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

    # User Story 38
    it "should have a link to update an item's information" do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_link"Update Item"
      click_link"Update Item"
      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end
  end

  it "has a picture based on items name" do
    visit merchant_item_path(@merchant1, @item1)

    image_src = "https://images.unsplash.com/photo"
    expect(page.find("#item-image")["src"]).to include(image_src)
  end
end
