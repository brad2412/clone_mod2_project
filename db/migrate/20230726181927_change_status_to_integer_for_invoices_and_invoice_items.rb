class ChangeStatusToIntegerForInvoicesAndInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoices, :status
    remove_column :invoice_items, :status

    add_column :invoices, :status, :integer, default: 0
    add_column :invoice_items, :status, :integer, default: 0
  end
end
