module Spree
  class BlogComment < ActiveRecord::Base
    attr_accessible :comment

    belongs_to :post, class_name: 'Spree::BlogPost'
    belongs_to :author, class_name: 'Spree::User'

    validates :comment, :post, :author, presence: true
    validates :comment, length: { minimum: 5 }
  end
end
