class AddAvatarToBlogPosts < ActiveRecord::Migration
  def change
    add_column :spree_blog_posts, :avatar_file_name, :string
    add_column :spree_blog_posts, :avatar_content_type, :string
    add_column :spree_blog_posts, :avatar_file_size, :integer
  end
end
