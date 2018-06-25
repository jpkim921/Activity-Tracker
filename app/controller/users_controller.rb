# require 'rack-flash'
require 'sinatra/base'
require 'sinatra/flash'
class UsersController < ApplicationController
  # use Rack::Flash

  get '/user/signup' do
    if !logged_in?
      erb :'/user/signup'
    else
      redirect '/home'
    end
  end

  post '/user/signup' do
    # binding.pry
    if User.all.any?{|x| x.username == params[:username]}
      redirect '/user/signup'
    end

    if params.values.any?{|param| param == ""}
      redirect '/user/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      flash[:message] = "Successfully signed up."
      redirect '/home'
    end
  end

  get '/user/login' do
    if !logged_in?
      erb :'/user/login'
    else
      redirect '/home'
    end
  end

  post '/user/login' do
    # binding.pry
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      redirect '/user/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/user/login'
    else
      redirect '/home'
    end
  end


end
