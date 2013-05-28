class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show]
  before_filter :correct_user,   only: [:edit, :update, :show]

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @tracker = Tracker.new
    if @user.save
      @tracker.update_attribute(:user_index, @user.id)
      @tracker.save
      sign_in @user
      flash[:success] = "Welcome to Vehicle Tracker!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to view_url
    else
      render 'edit'
    end
  end

  def authenticate
    user = User.find_by_name(params[:username])

    if user && user.authenticate(params[:password])
      respond_to do |format|
      format.html
      format.xml { render xml: {username: user.name, id: user.id} }
      end
    else
      respond_to do |format|
      format.xml { render xml: {id: error} }
      end
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
