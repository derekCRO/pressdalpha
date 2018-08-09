class AddCompanyToPostcode < ActiveRecord::Migration[5.1]
  def change
    add_reference :postcodes, :company, foreign_key: true
  end
end
