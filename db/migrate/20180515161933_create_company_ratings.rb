class CreateCompanyRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :company_ratings do |t|
      t.integer :job_id
      t.decimal :score, :precision => 8, :scale => 2
      t.integer :user_id
      t.integer  :company_id
      t.timestamps null: false
    end
  end
end
