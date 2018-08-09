class AddPostcodeToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :postcode, foreign_key: true
  end
end
