class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Group successfully created."
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @topics = @group.topics.paginate(page: params[:page])
  end

  def index
    @groups = Group.paginate(page: params[:page])
    @user = User.find(current_user.id)
  end

  private

  def group_params
    params.require(:group).permit(:name, :category, :description)
  end
end
