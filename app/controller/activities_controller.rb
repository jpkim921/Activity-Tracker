require 'rack-flash'
class ActivitiesController < ApplicationController
  use Rack::Flash

  get '/home' do
    # binding.pry
    if !logged_in?
      redirect '/login'
    else
      user = User.find_by_id(current_user.id)
      @activities = user.activities
      erb :'/activity/home'
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
    elsif params[:name] == ""
      flash[:message] = "Try again. Must enter activity name."
      redirect '/activity/new'
    else
      @activity = Activity.create(params)
      @activity.user_id = current_user.id
      @activity.save
      flash[:message] = "Successfully created activity."

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

  get '/activity/:id/edit' do
    # binding.pry
    if !logged_in?
      redirect '/login'
    else
      @activity = Activity.find(params[:id])
      if @activity.user_id == current_user.id
        erb :"/activity/edit"
      else
        redirect "/home"
      end
    end
  end

  patch '/activity/:id' do
    @activity = Activity.find(params[:id])
    if params.empty?
      redirect "/activity/#{@activity.id}/edit"
    else
      # binding.pry
      @activity.update(name: params[:name], activity_date: params[:activity_date], activity_time: params[:activity_time], distance: params[:distance], pace_avg: params[:pace_avg], speed_avg: params[:speed_avg], hr_avg:params[:hr_avg], user_id: current_user.id)
      redirect "/activity/#{@activity.id}"
    end
  end

  delete '/activity/:id/delete' do
    # @activity = Activity.find(params[:id])

    if !logged_in?
      redirect '/login'
    else

      @activity = Activity.find(params[:id])
      # binding.pry

      if @activity.user_id == current_user.id
        @activity.delete
        flash[:message] = "Successfully deleted activity."

        redirect '/home'
      else
        redirect "/login"
      end
    end
  end

end
