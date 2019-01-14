class SessionsController < ApplicationController
  def new
  	@title = "Log in"
  end

  def create
  	user = User.find_by(email: params[:session][:email])

  	if user && user.authenticate(password: params[:session][:password])
  		render html: 'success login'
  	else
  		flash[:danger] = "Invalid email/password combo"
  		render 'new'
  	end
  end
end
