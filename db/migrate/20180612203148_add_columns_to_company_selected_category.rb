class AddColumnsToCompanySelectedCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :company_selected_categories, :weekly_price_per_hour_3_months, :float, default: 0.0
    add_column :company_selected_categories, :weekly_price_per_hour_6_months, :float, default: 0.0
    add_column :company_selected_categories, :weekly_price_per_hour_12_months, :float, default: 0.0
    add_column :company_selected_categories, :fortnightly_price_per_hour_3_months, :float, default: 0.0
    add_column :company_selected_categories, :fortnightly_price_per_hour_6_months, :float, default: 0.0
    add_column :company_selected_categories, :fortnightly_price_per_hour_12_months, :float, default: 0.0
    add_column :company_selected_categories, :monthly_price_per_hour_3_months, :float, default: 0.0
    add_column :company_selected_categories, :monthly_price_per_hour_6_months, :float, default: 0.0
    add_column :company_selected_categories, :monthly_price_per_hour_12_months, :float, default: 0.0
    change_column :company_selected_categories, :price_per_hour, 'integer USING CAST(price_per_hour AS float)', default: 0.0
  end
end
