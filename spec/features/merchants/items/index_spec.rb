require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Safeway")
    @merchant2 = Merchant.create!(name: "Spatula City")

    @item1 = Item.create!(name: "cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
    @item2 = Item.create!(name: "bad cheese", description: "its cheese.", unit_price: 1337, merchant_id: @merchant1.id, enabled: true)
    @item3 = Item.create!(name: "Bacon", description: "its bacon.", unit_price: 2337, merchant_id: @merchant1.id, enabled: false)
    @item4 = Item.create!(name: "Chowda", description: "say it right.", unit_price: 5537, merchant_id: @merchant2.id, enabled: false)
  end

  describe "merchant items index page" do
    it "should list the names of the merchant items" do
      visit merchant_items_path(@merchant1)
      
      expect(page).to have_content("Your Items")
      expect(page).to have_content("cheese")
      expect(page).to have_content("bad cheese")
      expect(page).to have_content("Bacon")
      expect(page).to_not have_content("Name: Chowda")
    end
    
    it "should show all items as links to thats item's show page" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link("#{@item1.name}")
      expect(page).to have_link("#{@item2.name}")
      expect(page).to have_link("#{@item3.name}")
      expect(page).to_not have_link("#{@item4.name}")

      click_link ("#{@item1.name}")
      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    end

    it "should have a button to disable or enable next to item name" do
      visit merchant_items_path(@merchant1)

      within("tr#ei-#{@item1.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Item")
      end

      within("tr#ei-#{@item2.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Item")
      end

      within("tr#di-#{@item3.id}") do
        expect(page).to have_content("Disabled")
        expect(page).to_not have_content("Enabled")
        expect(page).to have_button("Enable Item")
      end

    end

    it "should have enabled and disabled sections that update" do
      visit merchant_items_path(@merchant1)

      within(".enabled") do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("cheese")
        expect(page).to have_content("bad cheese")
        expect(page).to_not have_content("Bacon")
      end

      within(".disabled") do
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content("Bacon")
        expect(page).to_not have_content("cheese")
      end
      
      within("tr#ei-#{@item2.id}") do
        click_button("Disable Item")
      end
      
      within("tr#di-#{@item3.id}") do
        click_button("Enable Item")
      end


      within(".enabled") do
        expect(page).to have_content("cheese")
        expect(page).to_not have_content("bad cheese")
        expect(page).to have_content("Bacon")
      end

      within(".disabled") do
        expect(page).to_not have_content("Bacon")
        expect(page).to have_content("bad cheese")
      end
    end
  end

end

# 9. Merchant Item Disable/Enable

# As a merchant
# When I visit my items index page (/merchants/:merchant_id/items)
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed