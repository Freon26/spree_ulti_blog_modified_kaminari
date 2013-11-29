FriendlyId.defaults do |config|
  config.use :reserved

  config.reserved_words = %w(new edit index session login logout users admin
    stylesheets assets javascripts images admin account cart checkout content
    login pg orders products s session signup shipments states t tax_categories
    user)
end
