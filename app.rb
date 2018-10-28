require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/user'
require './models/tweet'
require './models/connection'

enable :sessions

set :port, 8080
set :static, true
set :bind, '0.0.0.0'

#index controllers
get '/' do
    erb :index
end

#user controllers
post '/submit_user' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/users'
	else
		"Sorry, there was an error!"
	end
end

get '/create_user' do
	erb :create_user
end

get '/users' do
	@users = User.all
	erb :users
end

#tweet controllers
post '/submit_tweet' do
	@tweet = Tweet.new(params[:tweet])
	if @tweet.save
		redirect '/tweets'
	else
		"Sorry, there was an error!"
	end
end

get '/create_tweet' do
	erb :create_tweet
end

get '/tweets' do
	@tweets = Tweet.all
	@users = User.all
	erb :tweets
end

#connection (followers) controllers
post '/submit_connection' do
	@connection = Connection.new(params[:connection])
	if @connection.save
		redirect '/connections'
	else
		"Sorry, there was an error!"
	end
end

get '/create_connection' do
	erb :create_connection
end

get '/connections' do
	@connections = Connection.all
	@users = User.all
	erb :connections
end

#Registrations 
get '/registrations/signup' do
    erb :'/registrations/signup'
end

post '/registrations' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/sessions/login'
	else
		"Sorry, there was an error!"
	end
end

#sessions and login management
get '/sessions/login' do
	erb :'/sessions/login'
end

post '/sessions' do
	@user = User.find_by(email: params["email"], password: params["password"])
	if @user != nil
		session[:id] = @user.id
		redirect '/users/home'
	else
		redirect 'sessions/login'
	end
end

get '/sessions/logout' do
	session.clear
	redirect '/'
end

#users home 
get '/users/home' do
  @user = User.find(session[:id])
  @followers = Connection.where("follower_id = ?", @user.id)
  
  erb :'/users/home'
end