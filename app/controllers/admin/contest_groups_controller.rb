class Admin::ContestGroupsController < Admin::BaseController
  def index
    authorize :contest_group

    @contest_groups = ContestGroup.all
  end

  def new
    authorize :contest_group

    @contest_group = ContestGroup.new
  end

  def edit
    authorize :contest_group

    @contest_group = ContestGroup.find(params[:id])
  end

  def create
    authorize :contest_group

    @contest_group = ContestGroup.new(contest_group_params)

    if @contest_group.save
      redirect_to admin_contest_groups_path, notice: 'Групата бе създадена успешно.'
    else
      render :new
    end
  end

  def update
    authorize :contest_group

    @contest_group = ContestGroup.find(params[:id])

    if @contest_group.update(contest_group_params)
      redirect_to admin_contest_groups_path, notice: 'Групата бе обновена успешно.'
    else
      render :edit
    end
  end

  def destroy
    authorize :contest_group

    if Contest.where(contest_group_id: params[:id]).empty?
      ContestGroup.find(params[:id]).destroy
      redirect_to admin_contest_groups_path, notice: 'Групата бе изтрита успешно.'
    else
      flash[:error] = 'Групата не е празна. Моля, преместете състезанията в друга група'
      render :index
    end
  end

  private

    def contest_group_params
      params.require(:contest_group).permit(:name)
    end
end
