class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :spree_blogs do |t|
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps
    end

    add_index :spree_blogs, :slug, unique: true
  end
end
