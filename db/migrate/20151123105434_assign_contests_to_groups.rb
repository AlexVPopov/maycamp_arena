class AssignContestsToGroups < ActiveRecord::Migration
  def change
    group_mappings = {'арена'  => 'Арени',
                      'турнир' => 'Турнири',
                      'нои'    => 'Национални олимпиади',
                      'apio'   => 'Международни олимпиади',
                      'oi'     => 'Международни олимпиади'}

    group_mappings.each do |regexp, group_name|
      contest_group = ContestGroup.find_or_create_by(name: group_name)
      contests = Contest.where('name LIKE ?', "%#{regexp}%")
      contests.each { |contest| contest.update(contest_group: contest_group) }
    end

    miscellaneous_group = ContestGroup.create(name: 'Други състезания')
    miscellaneous_contests = Contest.where(contest_group_id: 0)
    miscellaneous_contests.each { |contest| contest.update(contest_group: miscellaneous_group) }
  end
end
