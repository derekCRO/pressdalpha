class AddRadiusToSiteSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :site_settings, :radius, :integer
  end
end
