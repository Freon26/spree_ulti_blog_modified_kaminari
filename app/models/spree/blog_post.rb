module Spree
  class BlogPost < ActiveRecord::Base
    paginates_per 10

    extend FriendlyId
    friendly_id :title, use: :scoped, scope: :blog

    attr_accessible :body, :posted_at, :teaser, :title, :author, :category_id, :featured, :avatar, :state

    belongs_to :blog, class_name: 'Spree::Blog'
    belongs_to :author, class_name: 'Spree::User'
    belongs_to :category, class_name: 'Spree::BlogCategory', foreign_key: 'category_id'
    has_many :comments, class_name: 'Spree::BlogComment', foreign_key: 'post_id'

    alias_method :blog_comments, :comments

    validates :title, :teaser, :body, :posted_at, :author, :blog, presence: true

    default_scope order('posted_at DESC, created_at DESC')
    scope :published, where('posted_at <= ? AND state = ?', Time.now, 'published')
    scope :featured, where(featured: true)
    scope :exclude, ->(blog_post) {
      where('id != ?', blog_post.id)
    }

    has_attached_file :avatar,
      styles: Proc.new{ |clip| clip.instance.avatar_sizes },
      default_style: :mini,
      url: Spree::Config.attachment_default_url.gsub('/products/', '/blog_posts/'),
      path: Spree::Config.attachment_path.gsub('/products/', '/blog_posts/'),
      convert_options: { all: '-strip -auto-orient' }

    include Spree::Core::S3Support
    supports_s3 :avatar

    state_machine :state, initial: :draft do
      event :conceptualize do
        transition [:published, :deleted] => :draft
      end

      event :publish do
        transition [:draft, :deleted] => :published
      end

      event :delete do
        transition [:draft, :published] => :deleted
      end
    end

    def image_content?
      avatar_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
    end

    def avatar_sizes
      hash = {}
      hash.merge!(mini: '125x125#', small: '249x249#', medium: '600x600>', large: '950x700>') if image_content?
      hash
    end

    private

    def normalize_friendly_id(string)
      [posted_at.year, sprintf('%02d', posted_at.month), sprintf('%02d', posted_at.day), super].join('/')
    end
  end
end
