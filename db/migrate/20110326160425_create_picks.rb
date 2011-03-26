class CreatePicks < ActiveRecord::Migration
  def self.up
    create_table :picks do |t|
      t.references :player
      t.string :team
      t.string :choice

      t.timestamps
    end
  end

  def self.down
    drop_table :picks
  end
end
