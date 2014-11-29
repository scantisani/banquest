class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :keypress
      t.text :map

      t.timestamps
    end
  end
end
