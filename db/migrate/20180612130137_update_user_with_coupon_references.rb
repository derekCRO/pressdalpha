class UpdateUserWithCouponReferences < ActiveRecord::Migration[5.1]
    def change
      add_column :users, :been_referred, :boolean
      add_column :users, :credit, :float
    end
  end
