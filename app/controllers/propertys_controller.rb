class PropertysController < ApplicationController

  get '/property/new' do
    if logged_in?
      erb :'/propertys/new'
    else
      redirect '/login'
    end
  end

  post '/property/new' do
    #binding.pry
    @property = Property.new(name: params[:name], category: params[:category], value: params[:value])
    @user = current_user
    if @property.save
      @user.propertys << @property
      @user.total_value += @property.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "The information you entered was incomplete. Please try again."
      redirect '/property/new'
    end
  end

  get '/property/:id/edit' do
    @property = Property.find(params[:id])
    if logged_in? && current_user.propertys.include?(@property)
      erb :'/propertys/edit'
    else
      redirect '/home'
    end
  end

  post '/property/:id' do
    #binding.pry
    @property = Property.find(params[:id])
    @user = current_user
    @user.total_value -= @property.value
    if @property.update(name: params[:name], category: params[:category], value: params[:value])
      @user.total_value += @property.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "Empty fields are not permitted. Please try again."
      redirect "/property/#{params[:id]}/edit"
    end
  end

  delete '/property/:id' do
    @property = Property.find(params[:id])
    @user = current_user
    @user.total_value -= @property.value
    @user.save
    @property.destroy
    flash[:message] = "You have successfully removed your Property Investment."
    redirect '/home'
  end

end
