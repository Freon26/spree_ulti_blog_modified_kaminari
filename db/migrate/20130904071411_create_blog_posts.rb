class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :spree_blog_posts do |t|
      t.string :title
      t.string :slug
      t.text :teaser
      t.text :body
      t.datetime :posted_at
      t.references :blog
      t.references :author
      t.references :category
      t.string :state

      t.timestamps
    end
    add_index :spree_blog_posts, :blog_id
    add_index :spree_blog_posts, :category_id
    add_index :spree_blog_posts, :author_id
  end
end
