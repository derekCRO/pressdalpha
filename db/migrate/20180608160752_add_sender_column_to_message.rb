class AddSenderColumnToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :sent_by, :string
  end
end
