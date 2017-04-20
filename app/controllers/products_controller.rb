class ProductsController < ApplicationController

  get '/product/new' do
    if logged_in?
      @title = "Add a New Bank Product Investment"
      erb :'/products/new'
    else
      redirect '/login'
    end
  end

  post '/product/new' do
    if logged_in?
      current_user.products.create(name: params[:name], category: params[:category], value: params[:value])
      if current_user.save
        current_user.update(total_value: current_user.total_value + params[:value].to_f)
        redirect '/home'
      else
        flash[:message] = "The information you entered was incomplete. Please try again."
        redirect '/product/new'
      end
    else
      redirect '/failure1'
    end
  end

  get '/product/:id' do
    if (@product ||= Product.find_by(id: params[:id])) && @product.user == current_user
      @title = "Bank Product Investment Details"
      erb :'/products/show'
    else
      redirect '/failure1'
    end
  end

  get '/product/:id/edit' do
    if (@product ||= Product.find_by(id: params[:id])) && @product.user == current_user
      @title = "Update your Bank Product Investment"
      erb :'/products/edit'
    else
      redirect '/failure1'
    end
  end

  put '/product/:id' do
    @product = Product.find_by(id: params[:id])
    if @product.user == current_user
      new_total_value = (current_user.total_value - @product.value)
      if @product.update(name: params[:name], category: params[:category], value: params[:value]) && current_user.update(total_value: new_total_value + @product.value)
        redirect '/home'
      else
        flash[:message] = "Empty fields are not permitted. Please try again."
        redirect "/product/#{params[:id]}/edit"
      end
    else
      redirect '/failure2'
    end
  end

  delete '/product/:id' do
    @product = Product.find_by(id: params[:id])
    if @product.user = current_user
      current_user.update(total_value: current_user.total_value - @product.value)
      @product.destroy
      flash[:message] = "You have successfully removed your Bank Product Investment."
      redirect '/home'
    else
      redirect '/failure2'
    end
  end

end
