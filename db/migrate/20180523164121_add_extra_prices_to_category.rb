class AddExtraPricesToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :weekly_price_per_hour_3_months, :float
    add_column :categories, :weekly_price_per_hour_6_months, :float
    add_column :categories, :weekly_price_per_hour_12_months, :float
    add_column :categories, :fortnightly_price_per_hour_3_months, :float
    add_column :categories, :fortnightly_price_per_hour_6_months, :float
    add_column :categories, :fortnightly_price_per_hour_12_months, :float
    add_column :categories, :monthly_price_per_hour_3_months, :float
    add_column :categories, :monthly_price_per_hour_6_months, :float
    add_column :categories, :monthly_price_per_hour_12_months, :float
  end
end
