class AddContestGroupIdToContests < ActiveRecord::Migration
  def change
    add_column :contests, :contest_group_id, :integer, null: false
    add_index :contests, :contest_group_id
  end
end
