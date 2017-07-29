require "sinatra"
require_relative "calfunctions.rb"

get '/' do
	erb :login
end

post '/login' do
	correct_login:{jkeiffer: 1234}
	username = params[:username]
	password = params[:password]
	message = "Incorrect Username or Password, please try again."
	success = "Login Successful"
	correct_login.each do
		if username == key && password == value
			redirect '/name?success=' + success
		elsif username == key
			message = "Incorrect password!"
			redirect '/?message=' + message
		elsif password == value
			message = "Incorrect username!"
			redirect '/?message=' + message
		else
			message = "Incorrect username and password!"

	 	redirect '/?message=' + message
	end