class Admin::ContestGroupsController < Admin::BaseController
  before_action :set_contest_group, only: [:show, :edit, :update, :destroy]

  def index
    authorize :contest_group

    @contest_groups = ContestGroup.all
  end

  def show
    authorize :contest_group
  end

  def new
    authorize :contest_group

    @contest_group = ContestGroup.new
  end

  def edit
    authorize :contest_group
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

    if @contest_group.update(contest_group_params)
      redirect_to admin_contest_groups_path, notice: 'Групата бе обновена успешно.'
    else
      render :edit
    end
  end

  def destroy
    authorize :contest_group

    @contest_group.destroy
    redirect_to admin_contest_groups_path, notice: 'Групата бе изтрита успешно.'
  end

  private
    def set_contest_group
      @contest_group = ContestGroup.find(params[:id])
    end

    def contest_group_params
      params.require(:contest_group).permit(:name)
    end
end
