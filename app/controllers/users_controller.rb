class UsersController < ApplicationController
  before_action :authenticate_user ,{only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user ,{only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user ,{only: [:edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(
        name:params[:name],
        email:params[:email],
        image_name:"default_user.jpg",
        password:params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
    
  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.save
  end

  def login_form
  end

  def login
    @user = User.find_by(email:params[:email])

    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
      session[:user_id] = @user.id
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def likes
  end


end
