class AddEnabledToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :enabled, :boolean, default: false
  end
end
