class Addcompanylocationidtouser < ActiveRecord::Migration[5.1]
  def change
	change_table :users do |s|
		s.integer :companylocation_id
	end	
  end
end
