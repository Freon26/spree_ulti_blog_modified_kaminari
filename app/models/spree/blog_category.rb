module Spree
  class BlogCategory < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    attr_accessible :name

    belongs_to :blog, class_name: 'Spree::Blog'
    has_many :posts, class_name: 'Spree::BlogPost', dependent: :nullify, foreign_key: 'category_id'

    validates :name, :slug, presence: true

    default_scope order(:name)
  end
end
