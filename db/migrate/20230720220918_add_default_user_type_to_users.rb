class AddDefaultUserTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_type, :string, default: 'standard'
  end
end
