class FundsController < ApplicationController

  get '/fund/new' do
    erb :'/funds/new'
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
      redirect '/fund/new'
    end
  end

  get '/fund/:id/edit' do
    @fund = Fund.find(params[:id])
    erb :'/funds/edit'
  end

  post '/fund/:id' do
    #binding.pry
    @fund = Fund.find(params[:id])
    @user = current_user
    @user.total_value -= @fund.value
    @fund.update(name: params[:name], category: params[:category], value: params[:value])
    @fund.save
    @user.total_value += @fund.value
    @user.save
    redirect '/home'
  end

  delete '/fund/:id' do
    @fund = Fund.find(params[:id])
    @user = current_user
    @user.total_value -= @fund.value
    @user.save
    @fund.destroy
    redirect '/home'
  end

end
