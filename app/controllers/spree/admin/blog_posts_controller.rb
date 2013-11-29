module Spree
  module Admin
    class BlogPostsController < Spree::Admin::ResourceController
      belongs_to 'spree/blog', find_by: :slug
      before_filter :load_data, only: [:new, :create, :edit, :update]

      private

      def location_after_save
        admin_blog_blog_posts_path(@blog_post.blog)
      end

      def load_data
        @blog_categories = @blog_post.blog.categories
        @blog_post.posted_at = Date.today if params[:action] == 'new'
        @blog_post.author = spree_current_user if params[:action] == 'create'
      end

      def collection_url
        if @blog_post.blog.present?
          admin_blog_blog_posts_path(@blog_post.blog)
        else
          super
        end
      end

      def find_resource
        if parent && parent.respond_to?(controller_name)
          parent.send(controller_name).find(params[:id])
        else
          model_class.find(params[:id])
        end
      end
    end
  end
end
