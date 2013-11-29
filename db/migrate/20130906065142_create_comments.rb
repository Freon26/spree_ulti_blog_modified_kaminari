class CreateComments < ActiveRecord::Migration
  def change
    create_table :spree_blog_comments do |t|
      t.references :post
      t.references :author
      t.text :comment

      t.timestamps
    end
    add_index :spree_blog_comments, :post_id
    add_index :spree_blog_comments, :author_id
  end
end
