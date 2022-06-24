class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :authenticate_user
  before_action :posts_ensure_correct_user, {only: [:edit, :update, :destroy]}
  def index
    @posts = Post.all.order(created_at: :desc)
    # @posts = Post.all.order(created_at: :desc)
    # 新規投稿追加のため追記
    @post = Post.new
    
  end

  def show
    @post = Post.find_by(id:params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: params[:id]).count  
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content:params[:content],
      user_id: @current_user.id,
      image: "no-image.png"
    )
      # 画像のファイル名をimageカラムに保存
    @post.save
      # 画像があったらpublicに保存
        if params[:image]  
          @post.image = "#{@post.id}.jpg"                        
          File.binwrite("public/post_images/#{@post.image}", params[:image].read)
        end

      if @post.save
        flash[:notice] = "投稿を作成しました"
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]
    if params[:image]            
      @post.image = "#{@post.id}.jpg"                        
      File.binwrite("public/post_images/#{@post.image}", params[:image].read)
    end
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
    
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"    
    redirect_to("/posts/index")
  end

  def posts_ensure_correct_user
    @post = Post.find_by(id:params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  # 画像投稿機能？？
  def user_params
    params.require(:user).permit(:name, :age, :img) 
  end

end
