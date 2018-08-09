class CreateJoinTablePostcodeCompany < ActiveRecord::Migration[5.1]
  def change
    create_join_table :postcodes, :companies do |t|
      t.index [:postcode_id, :company_id]
    end
  end
end
