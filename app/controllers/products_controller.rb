class ProductsController < ApplicationController

  get '/product/new' do
    erb :'/products/new'
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
      redirect '/product/new'
    end
  end

  get '/product/:id/edit' do
    @product = Product.find(params[:id])
    erb :'/products/edit'
  end

  post '/product/:id' do
    #binding.pry
    @product = Product.find(params[:id])
    @user = current_user
    @user.total_value -= @product.value
    @product.update(name: params[:name], category: params[:category], value: params[:value])
    @product.save
    @user.total_value += @product.value
    @user.save
    redirect '/home'
  end

  delete '/product/:id' do
    @product = Product.find(params[:id])
    @user = current_user
    @user.total_value -= @product.value
    @user.save
    @product.destroy
    redirect '/home'
  end

end
