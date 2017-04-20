class StocksController < ApplicationController

  get '/stock/new' do
    if logged_in?
      @title = "Add a New Stock Investment"
      erb :'/stocks/new'
    else
      redirect '/login'
    end
  end

  post '/stock/new' do
    if logged_in?
      current_user.stocks.create(name: params[:name], price: params[:price], number: params[:number])
      if current_user.save
        current_user.update(total_value: current_user.total_value + (params[:price].to_f*params[:number].to_f))
        redirect '/home'
      else
        flash[:message] = "The information you entered was incomplete. Please try again."
        redirect '/stock/new'
      end
    else
      redirect '/failure1'
    end
  end

  get '/stock/:id' do
    if (@stock ||= Stock.find_by(id: params[:id])) && @stock.user == current_user
      @title = "Stock Investment Details"
      erb :'/stocks/show'
    else
      redirect '/failure1'
    end
  end

  get '/stock/:id/edit' do
    if (@stock ||= Stock.find_by(id: params[:id])) && @stock.user == current_user
      @title = "Update your Stock Investment"
      erb :'/stocks/edit'
    else
      redirect '/failure1'
    end
  end

  put '/stock/:id' do
    @stock = Stock.find_by(id: params[:id])
    if @stock.user == current_user
      new_total_value = (current_user.total_value - (@stock.price*@stock.number))
      if @stock.update(name: params[:name], price: params[:price], number: params[:number]) && current_user.update(total_value: new_total_value + (@stock.price*@stock.number))
        redirect '/home'
      else
        flash[:message] = "Empty fields are not permitted. Please try again."
        redirect "/stock/#{params[:id]}/edit"
      end
    else
      redirect '/failure2'
    end
  end

  delete '/stock/:id' do
    @stock = Stock.find_by(id: params[:id])
    if @stock.user = current_user
      current_user.update(total_value: current_user.total_value - (@stock.price*@stock.number))
      @stock.destroy
      flash[:message] = "You have successfully removed your Stock Investment."
      redirect '/home'
    else
      redirect '/failure2'
    end
  end

end
