class AddAmountToCoupon < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :amount, :float
  end
end
