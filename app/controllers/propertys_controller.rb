class PropertysController < ApplicationController

  get '/property/new' do
    erb :'/propertys/new'
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
      redirect '/property/new'
    end
  end

  get '/property/:id/edit' do
    @property = Property.find(params[:id])
    erb :'/propertys/edit'
  end

  post '/property/:id' do
    #binding.pry
    @property = Property.find(params[:id])
    @user = current_user
    @user.total_value -= @property.value
    @property.update(name: params[:name], category: params[:category], value: params[:value])
    @property.save
    @user.total_value += @property.value
    @user.save
    redirect '/home'
  end

  delete '/property/:id' do
    @property = Property.find(params[:id])
    @user = current_user
    @user.total_value -= @property.value
    @user.save
    @property.destroy
    redirect '/home'
  end

end
