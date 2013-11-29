Deface::Override.new(
  virtual_path: 'spree/admin/users/show',
  name: 'add_user_info',
  insert_after: 'tr[data-hook="email"]',
  partial: "spree/admin/users/user_info",
  disabled: false
)

Deface::Override.new(
  virtual_path: 'spree/admin/users/_form',
  name: 'add_user_form',
  insert_bottom: '[data-hook="admin_user_form_fields"]',
  partial: "spree/admin/users/form_info",
  disabled: false
)

