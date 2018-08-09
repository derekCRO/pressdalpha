class Addfieldtouser < ActiveRecord::Migration[5.1]
  def change
  	change_table(:users) do |t|
  		t.change :phone, :string
  	end	
  end
end
