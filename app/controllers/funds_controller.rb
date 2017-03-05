class FundsController < ApplicationController

  get '/fund/new' do
    erb :'/funds/new'
  end

  post '/fund/new' do
    binding.pry
    @fund = Fund.new(name: params[:name], type: params[:type], value: params[:value])
  end

end
