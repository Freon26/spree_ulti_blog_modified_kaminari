class MakePostedAtADateTimeInBlogPosts < ActiveRecord::Migration
  def up
    change_column :spree_blog_posts, :posted_at, :datetime
  end

  def down
    change_column :spree_blog_posts, :posted_at, :date
  end
end
