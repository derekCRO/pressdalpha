class AddRatingsToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :rating_given, :boolean
  end
end
