module Spree
  class BlogPostsController < Spree::StoreController
    before_filter :load_blog
    before_filter :load_blog_category, only: [:index]

    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    respond_to :html

    def index
      if @blog_category
        @featured_blog_post = @blog_category.posts.published.featured.first
        @blog_posts = @blog_category.posts.published
      else
        @featured_blog_post = @blog.posts.published.featured.first
        @blog_posts = @blog.posts.published
      end
      @featured_blog_post = nil if params[:page].to_i > 1
      @blog_posts = @blog_posts.exclude(@featured_blog_post) if @featured_blog_post
      @blog_posts = @blog_posts.page(params[:page])
    end

    def show
      @blog_post = @blog.posts.published.find(params[:id])
      @blog_category = @blog_post.category if @blog_post && @blog_post.category
    end

    private

    def accurate_title
      if @blog_post
        [@blog.name, @blog_post.title].join(' - ')
      elsif @blog_category
        [@blog.name, @blog_category.name].join(' - ')
      elsif @blog
        @blog.name
      else
        super
      end
    end

    def load_blog
      @blog = Spree::Blog.find(params[:blog_id])
    end

    def load_blog_category
      @blog_category = @blog.categories.find(params[:blog_category_id]) if params[:blog_category_id]
    end
  end
end
