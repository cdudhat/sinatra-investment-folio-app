class StocksController < ApplicationController

  get '/stock/new' do
    if logged_in?
      erb :'/stocks/new'
    else
      redirect '/login'
    end
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
      flash[:message] = "The information you entered was incomplete. Please try again."
      redirect '/stock/new'
    end
  end

  get '/stock/:id/edit' do
    @stock = Stock.find(params[:id])
    if logged_in? && current_user.stocks.include?(@stock)
      erb :'/stocks/edit'
    else
      redirect '/home'
    end
  end

  post '/stock/:id' do
    #binding.pry
    @stock = Stock.find(params[:id])
    @user = current_user
    @user.total_value -= @stock.value

    if @stock.update(name: params[:name], price: params[:price], number: params[:number])
      @stock.value = @stock.price*@stock.number
      @stock.save
      @user.total_value += @stock.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "Empty fields are not permitted. Please try again."
      redirect "/stock/#{params[:id]}/edit"
    end
  end

  delete '/stock/:id' do
    @stock = Stock.find(params[:id])
    @user = current_user
    @user.total_value -= @stock.value
    @user.save
    @stock.destroy
    flash[:message] = "You have successfully removed your Stock Investment."
    redirect '/home'
  end

end
