class TopicsController < ApplicationController
  before_action :logged_in_user

  def new
    @group = Group.find(params[:group_id])
    @topic = Topic.new
  end

  def create
    @group = Group.find(params[:group_id])
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "Topic successfully created."
      redirect_to group_topic_path(@topic.group_id, @topic.id)
    else
      flash[:danger] = "Something went wrong. Please try again."
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page])
  end

  def index
  end

  def destroy
    @group = Group.find(params[:group_id])
    Topic.find(params[:id]).destroy
    flash[:success] = "Topic deleted"
    redirect_to @group
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :group_id)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end
end
