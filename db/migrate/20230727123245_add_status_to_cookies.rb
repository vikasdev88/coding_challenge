class AddStatusToCookies < ActiveRecord::Migration[7.0]
  def change
    add_column :cookies, :status, :integer, default: 0
  end
end
