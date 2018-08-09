class Addcompanyidintask < ActiveRecord::Migration[5.1]
  def change
  	change_table :tasks do |t|
  		t.integer :company_id
  		t.string :task_type
  	end
  end
end
