class AddFeaturedToBlogPosts < ActiveRecord::Migration
  def change
    add_column :spree_blog_posts, :featured, :boolean, default: false
  end
end
