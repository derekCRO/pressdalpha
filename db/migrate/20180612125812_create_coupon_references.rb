class CreateCouponReferences < ActiveRecord::Migration[5.1]
def change
  create_table :coupon_references do |t|
    t.integer  :coupon_id
    t.string   :code
    t.integer  :user_id
    t.integer  :job_id

    t.timestamps
  end
end
end
