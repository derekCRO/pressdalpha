class UpdateJobWithCouponDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :coupon_used, :boolean
    add_column :jobs, :coupon_id, :integer
    add_column :jobs, :coupon_refer, :boolean
    add_column :jobs, :coupon_discount, :float
  end
end
