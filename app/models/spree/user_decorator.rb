Spree::User.class_eval do
  attr_accessible :name, :about, :twitter, :facebook, :google_plus, :skype, :avatar

  has_attached_file :avatar,
    styles: Proc.new{ |clip| clip.instance.avatar_sizes },
    default_style: :mini,
    url: Spree::Config.attachment_default_url.gsub('/products/', '/users/'),
    path: Spree::Config.attachment_path.gsub('/products/', '/users/'),
    convert_options: { all: '-strip -auto-orient' }

  include Spree::Core::S3Support
  supports_s3 :avatar

  def image_content?
    avatar_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def avatar_sizes
    hash = {}
    hash.merge!(mini: '125x125#', small: '249x249#', medium: '600x600>', large: '950x700>') if image_content?
    hash
  end
end
