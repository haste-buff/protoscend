class UserController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where(nil)
    @users = @users.with_first_name(params[:first_name]) if params[:first_name].present?
    @users = @users.with_last_name(params[:last_name]) if params[:last_name].present?
    @users = @users.with_email(params[:email]) if params[:email].present?
    @users = @users.order(sort_column + " " + sort_direction)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update_attributes!(user_params)

    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :fname, :lname)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
