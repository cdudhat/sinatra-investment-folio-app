class SessionsController < ApplicationController

  get '/login' do
    if !logged_in?
      @title = "Log In to your account"
      erb :'/sessions/login'
    else
      flash[:message] = "You are already logged in."
      redirect '/home'
    end
  end

  post '/login' do
    if !logged_in?
      if @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/home'
        else
          flash[:message] = "You have entered incorrect login information. Please try again."
          redirect '/login'
        end
      elsif params[:email].empty?
        flash[:message] = "Empty fields are not permitted. Please try again."
        redirect '/login'
      else
        flash[:message] = "There is no account linked with this email address. Signup for a new account."
        redirect '/signup'
      end
    else
      flash[:message] = "You are already logged in."
      redirect '/home'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
