class AddForeignKeyToContests < ActiveRecord::Migration
  def change
    add_foreign_key :contests, :contest_groups
  end
end
