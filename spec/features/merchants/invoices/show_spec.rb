require "rails_helper"

RSpec.describe "Merchants Invoice Show Page" do
  before(:each) do

  end

  # User Story 15
  it "" do
    # As a merchant
    # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see information related to that invoice including:
    #   - Invoice id
    #   - Invoice status
    #   - Invoice created_at date in the format "Monday, July 18, 2019"
    #   - Customer first and last name
  end

  # User Story 16
  it "" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see all of my items on the invoice including:
    #   - Item name
    #   - The quantity of the item ordered
    #   - The price the Item sold for
    #   - The Invoice Item status
    # And I do not see any information related to Items for other merchants
  end

  # User Story 17
  it "" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see the total revenue that will be generated from all of my items on the invoice
  end

  # User Story 18
  it "" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated
  end
end