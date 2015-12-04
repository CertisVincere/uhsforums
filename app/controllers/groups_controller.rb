class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
  end

  def index
    @group = Group.paginate(page: params[:page])
    @user = User.find(current_user.id)
  end
end
