module Spree
  class Blog < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    attr_accessible :description, :name

    has_many :categories, class_name: 'Spree::BlogCategory', dependent: :destroy
    has_many :posts, class_name: 'Spree::BlogPost', dependent: :destroy

    alias_method :blog_categories, :categories
    alias_method :blog_posts, :posts

    validates :name, :slug, presence: true

    after_validation :move_friendly_id_error_to_name

    private

    def move_friendly_id_error_to_name
      errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
    end
  end
end
