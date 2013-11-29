module Spree
  module Admin
    class BlogCommentsController < Spree::Admin::ResourceController
      belongs_to 'spree/blog_post'

      private

      def location_after_save
        admin_blog_post_blog_comments_path(@blog_comment.post.id)
      end

      def collection_url
        if @blog_comment.post.present?
          admin_blog_post_blog_comments_path(@blog_comment.post.id)
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
