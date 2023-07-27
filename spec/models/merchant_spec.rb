require "rails_helper"

RSpec.describe Merchant do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Dangerway", enabled: true)
    @merchant2 = Merchant.create!(name: "Targete", enabled: true)
    @merchant3 = Merchant.create!(name: "Fifteen Bears", enabled: true)
    @merchant4 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant5 = Merchant.create!(name: "Freddy Meyers", enabled: false)
    @merchant6 = Merchant.create!(name: "Timmy Hortons", enabled: false)
  end

  it "returns all enabled merchants" do
    expect(Merchant.enabled).to eq([@merchant1, @merchant2, @merchant3, @merchant4])
  end

  it "returns all disabled merchants" do
    expect(Merchant.disabled).to eq([@merchant5, @merchant6])
  end
end