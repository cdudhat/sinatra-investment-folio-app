class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post "/signup" do
    #binding.pry
    if User.find_by(email: params[:email])
      flash[:message] = "This email is already linked to an existing account. Please Login."
      redirect '/login'
    elsif user = User.create(name: params[:name], email: params[:email], password: params[:password], total_value: 0)
      session[:user_id] = user.id
      redirect '/home'
    else
      redirect '/'
    end
  end

  get '/home' do
    #binding.pry
    if !logged_in?
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/users/home'
    end
  end

end
