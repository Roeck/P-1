class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5).includes(:photos, :user, :likes).
      order("created_at desc")
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: params[:images][img])
        end
      end

      redirect_to posts_path
      flash[:notice] = "Saved!"
    else
      flash[:alert] = "Something went wrong..."
      redirect_to posts_path
    end
  end
end