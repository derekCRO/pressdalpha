class CreatePartnerOpeningTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_opening_times do |t|
      t.string :title
      t.text :description
      t.date :start
      t.date :end
      t.time :starttime
      t.time :endtime
      t.boolean :is_open
      t.belongs_to :company, index: true

      t.timestamps
    end
  end
end
