class CreateCompanylocations < ActiveRecord::Migration[5.1]
  def change
    create_table :companylocations do |t|
      t.integer :company_id
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
