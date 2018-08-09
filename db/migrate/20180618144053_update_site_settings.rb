class UpdateSiteSettings < ActiveRecord::Migration[5.1]
def change
  add_column :site_settings, :pressd_promise_fee, :float, default: 0
end
end
