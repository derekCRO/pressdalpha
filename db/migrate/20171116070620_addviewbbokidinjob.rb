class Addviewbbokidinjob < ActiveRecord::Migration[5.1]
  def change
     change_table :jobs do |t|
  		t.string :view_job_id
  	end
  end
end
