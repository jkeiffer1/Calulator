require "sinatra"
require_relative "calcfunctions.rb"


get '/' do
	message = params[:message]
	newusername = params[:newusername]
	newpassword = params[:newpassword]
	erb :login, locals:{message: message, newusername: newusername, newpassword: newpassword}
end

get'/thiswontwork' do
	"hi there"
end

post '/login' do
	correct_login = {'jkeiffer' => "1234", 'scstew' => "4321", 'ldeems' => "1233"}
	username = params[:username]
	password = params[:password]
	newusername = params[:newusername]
	newpassword = params[:newpassword]
	correct_login.store(newusername, newpassword)
	message = "Incorrect Username or Password, please try again."
	success = "Login Successful"
	#{}"#{correct_login} #{newusername} newuser,new pass is #{newpassword}"
	#p "#{correct_login} correctlog"
	#p "#{loginhash} loghash"
	#p loginhash.class
	 correct_login.each_pair do |key, value|
	# 	p "#{key}#{value}"
		if username == key && password == value
			redirect '/name?success=' + success
		elsif username == key
			message = "Incorrect password!"
			redirect '/?message=' + message + "&newusername=" + newusername + "&newpassword=" + newpassword
		elsif password == value
			message = "Incorrect username!"
			redirect '/?message=' + message + "&newusername=" + newusername + "&newpassword=" + newpassword
		end
		message = "Incorrect username and password!"
		redirect '/?message=' + message + "&newusername=" + newusername + "&newpassword=" + newpassword
	
	 end
end

post '/create' do
	redirect '/create'
end

get '/create' do
	erb :create
end

post '/createnew' do
	newusername = params[:username]
	newpassword = params[:password]
	#p "#{newusername} newuser, #{newpassword} newpass"
	redirect '/?newusername=' + newusername + "&newpassword=" + newpassword
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
	msg = params[:msg]
	erb :calc, locals:{firstname: firstname, lastname: lastname, msg: msg}
end

post '/calc' do
	firstname = params[:firstname]
	lastname = params[:lastname]
	num1 = params[:num1]
	num2 = params[:num2]
	function = params[:function]
		if num2.to_i == 0
			msg = "cannot divide by zero, pls try again"
			redirect '/calc?firstname=' + firstname + "&lastname=" + lastname + "&msg=" + msg
		else
	outcome = math(function, num1.to_i, num2.to_i)
	oc = outcome.to_s
	redirect '/answer?firstname=' + firstname + "&lastname=" + lastname + "&num1=" + num1 + "&num2=" + num2 + "&function=" + function + "&oc=" + oc
	end
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