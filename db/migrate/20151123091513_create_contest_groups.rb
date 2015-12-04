class CreateContestGroups < ActiveRecord::Migration
  def change
    create_table :contest_groups do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
