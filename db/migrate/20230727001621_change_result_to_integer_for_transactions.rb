class ChangeResultToIntegerForTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :result

    add_column :transactions, :result, :integer, default: 0
  end
end
