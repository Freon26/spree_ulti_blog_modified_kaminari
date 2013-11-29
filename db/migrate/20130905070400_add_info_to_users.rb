class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :name, :string
    add_column :spree_users, :about, :text
    add_column :spree_users, :twitter, :string
    add_column :spree_users, :facebook, :string
    add_column :spree_users, :google_plus, :string
    add_column :spree_users, :skype, :string
  end
end
