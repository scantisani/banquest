class AddSaveDataToGame < ActiveRecord::Migration
  def change
    add_column :games, :save_data, :text
  end
end
