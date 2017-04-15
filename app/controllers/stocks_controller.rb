class StocksController < ApplicationController

  get '/stock/new' do
    if logged_in?
      erb :'/stocks/new'
    else
      redirect '/login'
    end
  end

  post '/stock/new' do
    @stock = Stock.new(name: params[:name], price: params[:price], number: params[:number], value: 0)
    @user = current_user
    if @stock.save
      @stock.value = @stock.price*@stock.number
      @stock.save
      @user.stocks << @stock
      @user.total_value += @stock.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "The information you entered was incomplete. Please try again."
      redirect '/stock/new'
    end
  end

  get '/stock/:id' do
    if Stock.exists?(params[:id])
      @stock = Stock.find(params[:id])
      if logged_in? && current_user.stocks.include?(@stock)
        erb :'/stocks/show'
      else
        flash[:message] = "The page you requested does not exist."
        redirect '/home'
      end
    else
      flash[:message] = "The page you requested does not exist."
      redirect '/home'
    end
  end

  get '/stock/:id/edit' do
    if Stock.exists?(params[:id])
      @stock = Stock.find(params[:id])
      if logged_in? && current_user.stocks.include?(@stock)
        erb :'/stocks/edit'
      else
        flash[:message] = "The page you requested does not exist."
        redirect '/home'
      end
    else
      flash[:message] = "The page you requested does not exist."
      redirect '/home'
    end
  end

  put '/stock/:id' do
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
