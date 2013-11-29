Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'add_blogs_tab',
  insert_bottom: '[data-hook="admin_tabs"], #admin_tabs[data-hook]',
  partial: "spree/admin/blogs/blogs_tab",
  disabled: false,
  original: '947913b0b6e4bd6a35c042c06e6d2984a0aa094b'
)
