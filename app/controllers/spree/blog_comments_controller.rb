module Spree
  class BlogCommentsController < Spree::StoreController
    before_filter :load_blog
    before_filter :load_blog_post
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    respond_to :html

    def create
      @blog_comment = @blog_post.comments.build(params[:blog_comment])
      @blog_comment.author = spree_current_user

      if @blog_comment.save
        flash[:notice] = Spree.t('flash.blog_comment.saved')
        redirect_to spree.blog_blog_post_path(@blog, @blog_post)
      else
        flash[:error] = Spree.t('flash.blog_comment.failed')
        render action: :new
      end
    end

    private

    def load_blog
      @blog = Spree::Blog.where(slug: params[:blog_id]).first
    end

    def load_blog_post
      @blog_post = @blog.posts.where(slug: params[:id]).first
    end
  end
end
