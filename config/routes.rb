Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blogs, except: [:show] do
      resources :blog_categories, only: [:index, :new, :create]
      resources :blog_posts, only: [:index, :new, :create]
    end

    resources :blog_categories, only: [:edit, :update, :destroy]

    resources :blog_posts, only: [:edit, :update, :destroy] do
      resources :blog_comments, only: [:index]
    end

    resources :blog_comments, only: [:edit, :update, :destroy]
  end

  get 'b/:blog_id/c/:blog_category_id', controller: :blog_posts, action: :index, as: :blog_blog_category_blog_posts
  post 'b/:blog_id/*id/comment', controller: :blog_comments, action: :create, as: :blog_blog_post_blog_comments
  get 'b/:blog_id/*id', controller: :blog_posts, action: :show, as: :blog_blog_post
  get 'b/:blog_id', controller: :blog_posts, action: :index, as: :blog_blog_posts
end
