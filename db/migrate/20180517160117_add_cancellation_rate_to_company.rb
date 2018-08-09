class AddCancellationRateToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :cancellation_amount, :integer
    add_column :companies, :using_promo_material, :boolean
  end
end
