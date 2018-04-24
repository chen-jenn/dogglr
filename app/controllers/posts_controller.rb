class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    # allows you to use the instance variable in the view
    @post = Post.new
    #by default will show the new.html.erb
  end

  def create
    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post) #@post.id technically, but this is the shortcut
    else
      render :new
    end
  end

  def edit
    # @post = Post.find params[:id] #need this variable so you can prepopulate your views/edit.html.erb page
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def authorize_user!
    unless can?(:manage, @post)
      flash[:alert] = "Access Denied"
      redirect_to post_path(@post)
    end
  end

  def post_params
    post_params = params.require(:post).permit([:title, :body])
  end

  def find_post
    @post = Post.find params[:id]
  end

end
