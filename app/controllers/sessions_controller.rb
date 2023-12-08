class SessionsController < ApplicationController
  def new

  end
def create
  user = User.find_by(email: params[:email])

  if user&.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:notice] = 'Login successful'
    redirect_to blogs_path
  else
    flash[:alert] = 'Invalid Email or Password'
    render :new
  end
end


  def destroy
    session[:user_id] = nil
    flash[:notice]="Logged Out"
    redirect_to '/login'
  end
end