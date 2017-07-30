require "sinatra"
require_relative "calcfunctions.rb"


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
	redirect '/calc?firstname=' + firstname + "&lastname=" + lastname
end

get'/calc' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	erb :calc, locals:{firstname: firstname, lastname: lastname}
end

post '/calc' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	num1 = params[:num1]
	num2 = params[:num2]
	function = params[:function]
	outcome = math(function, num1.to_i, num2.to_i)
	oc = outcome.to_s
	redirect '/answer?firstname=' + firstname + "&lastname=" + lastname + "&num1=" + num1 + "&num2=" + num2 + "&function=" + function + "&oc=" + oc
end

get '/answer' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	num1 = params[:num1]
	num2 = params[:num2]
	function = params[:function]
	oc = params[:oc]
	if function == "add"
		function = "+"
	end
	erb :answer, locals:{firstname: firstname, lastname: lastname, num1: num1, num2: num2, function: function, oc: oc}
end

post '/answer' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	redirect '/calc?firstname=' + firstname + "&lastname=" + lastname
end