class CreateEnquirypostcode < ActiveRecord::Migration[5.1]
  def change
    create_table :enquirypostcodes do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :postcode
      t.string :service_type
      t.boolean :inform_me

      t.timestamps
    end
  end
end
