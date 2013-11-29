module Spree
  module Admin
    class BlogCategoriesController < Spree::Admin::ResourceController
      belongs_to 'spree/blog', find_by: :slug
      before_filter :load_data, only: [:new, :create, :edit, :update]

      private

      def location_after_save
        admin_blog_blog_categories_path(@blog_category.blog)
      end

      def load_data
        @blogs = Spree::Blog.all
      end

      def collection_url
        if @blog_category.blog.present?
          admin_blog_blog_categories_path(@blog_category.blog)
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
