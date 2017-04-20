class PropertysController < ApplicationController

  get '/property/new' do
    if logged_in?
      @title = "Add a New Investment Property"
      erb :'/propertys/new'
    else
      redirect '/login'
    end
  end

  post '/property/new' do
    if logged_in?
      current_user.propertys.create(name: params[:name], category: params[:category], value: params[:value])
      if current_user.save
        current_user.update(total_value: current_user.total_value + params[:value].to_f)
        redirect '/home'
      else
        flash[:message] = "The information you entered was incomplete. Please try again."
        redirect '/property/new'
      end
    else
      redirect '/failure1'
    end
  end

  get '/property/:id' do
    if (@property ||= Property.find_by(id: params[:id])) && @property.user == current_user
      @title = "Investment Property Details"
      erb :'/propertys/show'
    else
      redirect '/failure1'
    end
  end

  get '/property/:id/edit' do
    if (@property ||= Property.find_by(id: params[:id])) && @property.user == current_user
      @title = "Update your Investment Property"
      erb :'/propertys/edit'
    else
      redirect '/failure1'
    end
  end

  put '/property/:id' do
    @property = Property.find_by(id: params[:id])
    if @property.user == current_user
      new_total_value = (current_user.total_value - @property.value)
      if @property.update(name: params[:name], category: params[:category], value: params[:value]) && current_user.update(total_value: new_total_value + @property.value)
        redirect '/home'
      else
        flash[:message] = "Empty fields are not permitted. Please try again."
        redirect "/property/#{params[:id]}/edit"
      end
    else
      redirect '/failure2'
    end
  end

  delete '/property/:id' do
    @property = Property.find_by(id: params[:id])
    if @property.user = current_user
      current_user.update(total_value: current_user.total_value - @property.value)
      @property.destroy
      flash[:message] = "You have successfully removed your Property Investment."
      redirect '/home'
    else
      redirect '/failure2'
    end
  end

end
