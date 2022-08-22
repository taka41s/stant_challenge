class CreatePalestras < ActiveRecord::Migration[6.1]
  def change
    create_table :palestras do |t|
      t.string :event
      t.integer :duration
      t.string :schedule

      t.timestamps
    end
  end
end
