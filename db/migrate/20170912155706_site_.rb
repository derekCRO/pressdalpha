class Site < ActiveRecord::Migration[5.1]
  def change
     create_table :site_settings do |t|
      t.string :facebook_link
      t.string :site_email
      t.string :phone_no
      t.string :google_plus_link

      
    end
  end
end
