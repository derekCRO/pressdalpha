class AddPartnerOpeningTimesToCompany < ActiveRecord::Migration[5.1]
  def change
        add_reference :companies, :partner_opening_times, foreign_key: true
  end
end
