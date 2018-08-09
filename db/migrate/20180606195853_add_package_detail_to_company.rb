class AddPackageDetailToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :selected_package, :string
  end
end
