require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    @customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    @customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    @customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    @customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
    @customer8 = Customer.create!(first_name: "Smelly", last_name: "Cow")


    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: Time.new(2012,3,4))
    @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id, created_at: Time.new(2000,5,6))
    @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id, created_at: Time.new(1999,5,6))
    @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id, created_at: Time.new(2030,5,4))
    @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2012,5,4))
    @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2016,7,6))
    @invoice8 = Invoice.create!(status: "completed", customer_id: @customer8.id, created_at: Time.new(2015,5,3))
  end

  #User story 32
  it "has a list of all invoices in the system (with links)" do
    visit admin_invoices_path

    expect(page).to have_link("Invoice ##{@invoice1.id}", href: admin_invoice_path(@invoice1))
    expect(page).to have_link("Invoice ##{@invoice2.id}", href: admin_invoice_path(@invoice2))
    expect(page).to have_link("Invoice ##{@invoice3.id}", href: admin_invoice_path(@invoice3))
    expect(page).to have_link("Invoice ##{@invoice4.id}", href: admin_invoice_path(@invoice4))
    expect(page).to have_link("Invoice ##{@invoice5.id}", href: admin_invoice_path(@invoice5))
    expect(page).to have_link("Invoice ##{@invoice6.id}", href: admin_invoice_path(@invoice6))
    expect(page).to have_link("Invoice ##{@invoice7.id}", href: admin_invoice_path(@invoice7))
    expect(page).to have_link("Invoice ##{@invoice8.id}", href: admin_invoice_path(@invoice8))
  end

end