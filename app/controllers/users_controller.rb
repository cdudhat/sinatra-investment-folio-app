class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post "/signup" do
    #binding.pry
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/home'
    else
      redirect '/failure'
    end
  end

  get '/home' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/users/home'
    end
  end

  get '/failure' do
    erb :'/users/failure'
  end

end
