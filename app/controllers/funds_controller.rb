class FundsController < ApplicationController

  get '/fund/new' do
    if logged_in?
      @title = "Add a New Retirement Fund Investment"
      erb :'/funds/new'
    else
      redirect '/login'
    end
  end

  post '/fund/new' do
    if logged_in?
      current_user.funds.create(name: params[:name], category: params[:category], value: params[:value])
      if current_user.save
        current_user.update(total_value: current_user.total_value + params[:value].to_f)
        redirect '/home'
      else
        flash[:message] = "The information you entered was incomplete. Please try again."
        redirect '/fund/new'
      end
    else
      redirect '/failure1'
    end
  end

  get '/fund/:id' do
    if (@fund ||= Fund.find_by(id: params[:id])) && @fund.user == current_user
      @title = "Retirement Fund Investment Details"
      erb :'/funds/show'
    else
      redirect '/failure1'
    end
  end

  get '/fund/:id/edit' do
    if (@fund ||= Fund.find_by(id: params[:id])) && @fund.user == current_user
      @title = "Update your Retirement Fund Investment"
      erb :'/funds/edit'
    else
      redirect '/failure1'
    end
  end

  put '/fund/:id' do
    @fund = Fund.find_by(id: params[:id])
    if @fund.user == current_user
      new_total_value = (current_user.total_value - @fund.value)
      if @fund.update(name: params[:name], category: params[:category], value: params[:value]) && current_user.update(total_value: new_total_value + @fund.value)
        redirect '/home'
      else
        flash[:message] = "Empty fields are not permitted. Please try again."
        redirect "/fund/#{params[:id]}/edit"
      end
    else
      redirect '/failure2'
    end
  end

  delete '/fund/:id' do
    @fund = Fund.find_by(id: params[:id])
    if @fund.user = current_user
      current_user.update(total_value: current_user.total_value - @fund.value)
      @fund.destroy
      flash[:message] = "You have successfully removed your Retirement Fund Investment."
      redirect '/home'
    else
      redirect '/failure2'
    end
  end

end
