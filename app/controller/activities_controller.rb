class ActivitiesController < ApplicationController
  get '/activities' do
    if !logged_in?
      redirect '/login'
    else
      @activities = Activity.all
      erb :'/activity/activities'
    end
  end

  get '/activity/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/activity/new'
    end
  end

  post '/activity/new' do
    # binding.pry
    if !logged_in?
      redirect '/login'
    elsif params.empty?
      redirect '/activity/new'
    else
      # category = Category.new(activity_type: params[:category])
      params.delete_if { |k, v| v == "" || k == "category" }
      @activity = Activity.create(params)
      redirect "/activity/#{@activity.id}"
    end
  end

  get '/activity/:id' do
   @activity = Activity.find(params[:id])
   if logged_in?
     erb :"/activity/show_activity"
   else
     redirect '/login'
   end
  end


end
