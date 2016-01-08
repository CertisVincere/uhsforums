class TopicsController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "Topic successfully created."
      redirect_to @topic
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page])
  end

  def index
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :group_id)
  end
end
