class AddStaffRotasEnableToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :staff_rotas_enable, :boolean,  default: false
  end
end
