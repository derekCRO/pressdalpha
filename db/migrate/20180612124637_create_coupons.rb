class CreateCoupons < ActiveRecord::Migration[5.1]
def change
  create_table :coupons do |t|
    t.string   :code
    t.string   :type
    t.integer  :originator
    t.date  :expires

    t.timestamps
  end
end
end
