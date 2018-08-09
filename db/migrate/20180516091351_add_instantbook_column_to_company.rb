class AddInstantbookColumnToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :instant_book, :boolean, default: false
    add_column :companies, :preferred_partner, :boolean, default: false
  end
end
