class PostsController < ApplicationController
  before_action :logged_in_user

  def new
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Successful post"
      redirect_to group_topic_post_path(@group, @topic, @post.id)
    else
      flash[:danger] = "Something went wrong. Please try again."
      redirect_to new_group_topic_post_path(@group, @topic)
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :attachment, :user_id, :group_id, :topic_id)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

end
