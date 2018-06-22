class UsersController < ApplicationController

  get '/user/signup' do
    if !logged_in?
      erb :'/user/signup'
    else
      redirect '/home'
    end
  end

  post '/user/signup' do
    if params.values.any?{|param| param == ""}
      redirect '/user/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/activities'
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
