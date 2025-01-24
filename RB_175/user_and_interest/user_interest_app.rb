require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erb'
require_relative 'extract_name'
require 'yaml'

def retrieve_name_from(url)
  url_array = url.split("/").join(" ").split
  if url_array.length == 3
    url_array.last.split("-").map { |name| name.capitalize}
  else
    ["Welcome To User Interest's"]
  end
end

before do
  @first, @last = retrieve_name_from(url)
  @user_names = extract_name("ji")
end

get '/' do 
  erb :user
end

get '/jamy-rustenburg' do 
  erb :jamyrustenburgug
end

get '/nora-alnes' do 
  erb :noraalnes
end

get '/hiroko-ohara' do 
  erb :hirokoohara
end