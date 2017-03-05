class StocksController < ApplicationController

  get '/stock/new' do
    erb :'/stocks/new'
  end

  post '/stock/new' do
    binding.pry
    @stock = Stock.new(params)
  end
  
end
