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
    if current_user.nil?
      redirect_to login_url
    else
      @user = current_user
      @groups = @user.groups.paginate(page: params[:page])
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  private

  def group_params
    params.require(:group).permit(:name, :category, :description, :user_id)
  end

end
