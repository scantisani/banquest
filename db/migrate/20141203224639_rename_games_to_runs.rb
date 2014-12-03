class RenameGamesToRuns < ActiveRecord::Migration
  def change
    rename_table :games, :runs
  end
end
