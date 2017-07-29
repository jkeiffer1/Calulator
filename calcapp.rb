require "sinatra"


get '/' do
	message = params[:message]
	erb :login, locals:{message: message}
end

post '/login' do
	correct_login = {jkeiffer: "1234", scstew: "4321", ldeems: "1233"}
	username = params[:username]
	password = params[:password]
	message = "Incorrect Username or Password, please try again."
	success = "Login Successful"
	correct_login.each_pair do |key, value|
		if username == key.to_s && password == value
			redirect '/name?success=' + success
		elsif username == key.to_s
			message = "Incorrect password!"
			redirect '/?message=' + message
		elsif password == value
			message = "Incorrect username!"
			redirect '/?message=' + message
		else
			message = "Incorrect username and password!"
			redirect '/?message=' + message
		end
	
	end
end

get '/name' do
	success = params[:success]
	erb :names, locals:{success: success}
end

post '/names' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	success = params[:success]
end