class StocksController < ApplicationController

  get '/stock/new' do
    erb :'/stocks/new'
  end

  post '/stock/new' do
    #binding.pry
    @stock = Stock.new(name: params[:name], price: params[:price], number: params[:number], value: 0)
    @stock.value = @stock.price*@stock.number
    @user = current_user
    if @stock.save
      @user.stocks << @stock
      @user.total_value += @stock.value
      @user.save
      redirect '/home'
    else
      redirect '/stock/new'
    end
  end

  get '/stock/:id/edit' do
    @stock = Stock.find(params[:id])
    erb :'/stocks/edit'
  end

  post '/stock/:id' do
    #binding.pry
    @stock = Stock.find(params[:id])
    @user = current_user
    @user.total_value -= @stock.value
    @stock.update(name: params[:name], price: params[:price], number: params[:number])
    @stock.value = @stock.price*@stock.number
    @stock.save
    @user.total_value += @stock.value
    @user.save
    redirect '/home'
  end

  delete '/stock/:id' do
    @stock = Stock.find(params[:id])
    @user = current_user
    @user.total_value -= @stock.value
    @user.save
    @stock.destroy
    redirect '/home'
  end

end
