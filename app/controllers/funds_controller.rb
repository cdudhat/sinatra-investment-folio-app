class FundsController < ApplicationController

  get '/fund/new' do
    if logged_in?
      erb :'/funds/new'
    else
      redirect '/login'
    end
  end

  post '/fund/new' do
    #binding.pry
    @fund = Fund.new(name: params[:name], category: params[:category], value: params[:value])
    @user = current_user
    if @fund.save
      @user.funds << @fund
      @user.total_value += @fund.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "The information you entered was incomplete. Please try again."
      redirect '/fund/new'
    end
  end

  get '/fund/:id/edit' do
    if Fund.exists?(params[:id])
      @fund = Fund.find(params[:id])
      if logged_in? && current_user.funds.include?(@fund)
        erb :'/funds/edit'
      else
        flash[:message] = "The page you requested does not exist."
        redirect '/home'
      end
    else
      flash[:message] = "The page you requested does not exist."
      redirect '/home'
    end
  end

  post '/fund/:id' do
    #binding.pry
    @fund = Fund.find(params[:id])
    @user = current_user
    @user.total_value -= @fund.value
    if @fund.update(name: params[:name], category: params[:category], value: params[:value])
      @user.total_value += @fund.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "Empty fields are not permitted. Please try again."
      redirect "/fund/#{params[:id]}/edit"
    end
  end

  delete '/fund/:id' do
    @fund = Fund.find(params[:id])
    @user = current_user
    @user.total_value -= @fund.value
    @user.save
    @fund.destroy
    flash[:message] = "You have successfully removed your Retirement Fund Investment."
    redirect '/home'
  end

end
