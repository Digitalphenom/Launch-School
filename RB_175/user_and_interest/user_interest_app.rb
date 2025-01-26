require 'sinatra'
require 'tilt/erb'
require_relative 'extract_data'
require 'yaml'
require 'pry'

configure :development do
  require 'sinatra/reloader'
  also_reload './**/*.rb' # Watches all .rb files for changes
end

helpers do
  def user_interest_count
    @user_content.reduce(0) { |acc, ele| acc + ele.size }
  end
end

def check_url
  url_array = url.split('/').join(' ').split

  if url_array.include?('home') || url_array.length < 3
    ''
  else
    current_userdata(url_array)
  end
end

def current_userdata(url_array)
  @first, @last = url_array.last.split('-')
  @user_email = @yaml[@first.downcase.to_sym][:email]
  @user_interests = @yaml[@first.downcase.to_sym][:interests]
end

before do
  @user_names, @user_emails, @user_content = extract_data
  check_url
end

get '/' do
  redirect to('/home')
end

get '/home' do
  erb :home
end

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


get "/Jamy-Rustenburg" do
	erb :'/users/jamyrustenburg'
end

get "/Derek-Awesomekid" do
	erb :'/users/derekawesomekid'
end

get "/Nora-Alnes" do
	erb :'/users/noraalnes'
end

get "/Hiroko-Ohara" do
	erb :'/users/hirokoohara'
end
