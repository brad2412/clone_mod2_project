require "csv"
# require "rails/all"

# customer_file_path = "../db/data/customers"


# rails csv_load:customers
namespace :csv_load do
  desc "loads the customer CSV"
  task :customers => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    customers = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    customers.each do |row|
      customer = Customer.new
      customer.first_name = row[:first_name]
      customer.last_name = row[:last_name]
      customer.id = row[:id]
      customer.created_at = row[:created_at]
      customer.updated_at = row[:updated_at]
      customer.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customers Loaded"
  end
end

namespace :csv_load do
  desc "loads the invoices CSV"
  task :invoices => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'invoices.csv'))
    invoices = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    invoices.each do |row|
      invoice = Invoice.new
      invoice.customer_id = row[:customer_id]
      invoice.status = row[:status]
      invoice.id = row[:id]
      invoice.created_at = row[:created_at]
      invoice.updated_at = row[:updated_at]
      invoice.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices Loaded"
  end
end

namespace :csv_load do
  desc "loads the merchants CSV"
  task :merchants => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'merchants.csv'))
    merchants = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    merchants.each do |row|
      merchant = Merchant.new
      merchant.name = row[:name]
      merchant.id = row[:id]
      merchant.created_at = row[:created_at]
      merchant.updated_at = row[:updated_at]
      merchant.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchants Loaded"
  end
end

namespace :csv_load do
  desc "loads the items CSV"
  task :items => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'items.csv'))
    items = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    items.each do |row|
      item = Item.new
      item.name = row[:name]
      item.description = row[:description]
      item.unit_price = row[:unit_price]
      item.merchant_id = row[:merchant_id]
      item.id = row[:id]
      item.created_at = row[:created_at]
      item.updated_at = row[:updated_at]
      item.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Items Loaded"
  end
end


namespace :csv_load do
  desc "loads the invoice_items CSV"
  task :invoice_items => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))
    invoice_items = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    invoice_items.each do |row|
      invoice_item = InvoiceItem.new
      invoice_item.item_id = row[:item_id]
      invoice_item.invoice_id = row[:invoice_id]
      invoice_item.quantity = row[:quantity]
      invoice_item.unit_price = row[:unit_price]
      invoice_item.status = row[:status]
      invoice_item.id = row[:id]
      invoice_item.created_at = row[:created_at]
      invoice_item.updated_at = row[:updated_at]
      invoice_item.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "Invoice Items Loaded"
  end
end

namespace :csv_load do
  desc "loads the transactions CSV"
  task :transactions => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'transactions.csv'))
    transactions = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    transactions.each do |row|
      transaction = Transaction.new
      transaction.invoice_id = row[:invoice_id]
      transaction.credit_card_number = row[:credit_card_number]
      transaction.credit_card_expiration_date = row[:credit_card_expiration_date]
      transaction.result = row[:result]
      transaction.id = row[:id]
      transaction.created_at = row[:created_at]
      transaction.updated_at = row[:updated_at]
      transaction.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transactions Loaded"
  end
end

namespace :csv_load do
  desc "loads all csv files"
  task :all => :environment do
    all = [
      :customers,
      :invoices,
      :merchants,
      :items,
      :invoice_items,
      :transactions
    ]
    all.each do |file|
      Rake::Task["csv_load:#{file}"].invoke
    end
    puts "All Loaded"
  end
end