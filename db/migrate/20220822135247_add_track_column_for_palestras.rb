class AddTrackColumnForPalestras < ActiveRecord::Migration[6.1]
  def change
    add_column :palestras, :track, :string
  end
end
