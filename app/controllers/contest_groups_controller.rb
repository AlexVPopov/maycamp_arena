class ContestGroupsController < ApplicationController
  def show
    @contests = Contest.includes(:problems)
                       .paginate(page: params.fetch(:page, 1), per_page: 20)
                       .practicable
                       .visible
                       .where(contest_group_id: params[:id])
                       .order(end_time: :desc)
  end
end
