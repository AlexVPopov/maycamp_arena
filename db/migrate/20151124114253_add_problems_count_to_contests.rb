class AddProblemsCountToContests < ActiveRecord::Migration
  def change
    add_column :contests, :problems_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { Contest.pluck(:id).each { |id| Contest.reset_counters(id, :problems) } }
    end
  end
end
