class UsersController < ApplicationController
  def new

  end
  
  def create
    user = User.new(user_params)
    if user.save
      flash[:notice]="Signup successful"
    else
      flash[:notice]="Please try again"
      redirect_to '/signup'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
    end
end