class ProductsController < ApplicationController

  get '/product/new' do
    if logged_in?
      erb :'/products/new'
    else
      redirect '/login'
    end
  end

  post '/product/new' do
    #binding.pry
    @product = Product.new(name: params[:name], category: params[:category], value: params[:value])
    @user = current_user
    if @product.save
      @user.products << @product
      @user.total_value += @product.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "The information you entered was incomplete. Please try again."
      redirect '/product/new'
    end
  end

  get '/product/:id/edit' do
    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
      if logged_in? && current_user.products.include?(@product)
        erb :'/products/edit'
      else
        flash[:message] = "The page you requested does not exist."
        redirect '/home'
      end
    else
      flash[:message] = "The page you requested does not exist."
      redirect '/home'
    end
  end

  post '/product/:id' do
    #binding.pry
    @product = Product.find(params[:id])
    @user = current_user
    @user.total_value -= @product.value
    if @product.update(name: params[:name], category: params[:category], value: params[:value])
      @user.total_value += @product.value
      @user.save
      redirect '/home'
    else
      flash[:message] = "Empty fields are not permitted. Please try again."
      redirect "/product/#{params[:id]}/edit"
    end
  end

  delete '/product/:id' do
    @product = Product.find(params[:id])
    @user = current_user
    @user.total_value -= @product.value
    @user.save
    @product.destroy
    flash[:message] = "You have successfully removed your Bank Product Investment."
    redirect '/home'
  end

end
