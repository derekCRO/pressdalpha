class AddSettingsToSiteSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :site_settings, :twitter_link, :string
    add_column :site_settings, :instagram_link, :string
    add_column :site_settings, :linkedin_link, :string
    add_column :site_settings, :angellist_link, :string
    add_column :site_settings, :maintenance_mode, :boolean
    add_column :site_settings, :favicon, :string
    add_column :site_settings, :company_name, :string
    add_column :site_settings, :website_name, :string
    add_column :site_settings, :meta_description, :string
    add_column :site_settings, :registrations_available, :boolean
    add_column :site_settings, :bookings_available, :boolean
    add_column :site_settings, :site_language, :string
    add_column :site_settings, :time_zone, :string
  end
end
