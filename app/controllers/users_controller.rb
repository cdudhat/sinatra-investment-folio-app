class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      @title = "Sign Up for a New Account Today!"
      erb :'/users/signup'
    else
      redirect '/home'
    end
  end

  post "/signup" do
    if !logged_in?
      if User.find_by(email: params[:email])
        flash[:message] = "This email is already linked to an existing account. Please Log In."
        redirect '/login'
      else
        user = User.new(name: params[:name], email: params[:email], password: params[:password], total_value: 0)
        if user.save
          session[:user_id] = user.id
          redirect '/home'
        else
          flash[:message] = "Empty fields are not permitted. Please try again."
          redirect '/signup'
        end
      end
    else
      redirect '/failure2'
    end
  end

  get '/home' do
    if !logged_in?
      flash[:message] = "You're not logged in. Please Log In."
      redirect '/login'
    else
      @title = "Welcome to your Investments Page"
      @heading = "Hi, " + current_user.name.to_s + "! Welcome to your Investments Page"
      erb :'/users/home'
    end
  end

  get '/failure1' do
    flash[:message] = "The page you requested does not exist."
    redirect '/home'
  end

  get '/failure2' do
    flash[:message] = "Your action cannot be completed."
    redirect '/home'
  end

end
