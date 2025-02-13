require 'sinatra'
require 'sinatra/reloader'
require 'erubi'
require 'redcarpet'

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

def valid_extension?(ext)
  %w[.txt .md].include?(ext)
end

def session
  last_request.env['rack.session']
end

def data_path
  if ENV['RACK_ENV'] == 'test'
    File.expand_path('test/data', __dir__)
  else
    File.expand_path('data', __dir__)
  end
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text)
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when '.txt'
    headers['Content-Type'] = 'text/plain'
    content
  when '.md'
    render_markdown(content)
  end
end

get '/' do
  session[:user_state] = false unless session[:user_state]
  pattern = File.join(data_path, '*')
  @files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  erb :index
end

get '/new' do
  erb :new
end

get '/users/login' do
  erb :signin
end

get '/:filename' do
  file_path = File.join(data_path, params[:filename])

  if File.exist?(file_path)
    load_file_content(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect '/'
  end
end

get '/:filename/edit' do
  file_path = File.join(data_path, params[:filename])

  @filename = params[:filename]
  @content = File.read(file_path)

  erb :edit
end

def valid_user?(username, password)
  username == 'Admin' && password == 'secret'
end

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

post '/users/login' do
  if valid_user?(params[:username], params[:password])
    session[:user_state] = true
    session[:message] = 'Welcome!'
    session[:username] = params[:username]
    redirect '/'
  else
    session[:message] = 'Invalid credentials'
    status 422
    erb :signin
  end
end

post '/users/logout' do
  session[:user_state] = false
  session[:message] = 'You have been loged out.'
  redirect '/'
end

post '/create' do
  ext = File.extname(params[:document])

  if params[:document].empty?
    session[:message] = 'A name is required'
    status 422
    erb :new
  elsif valid_extension?(ext)
    file_path = File.join(data_path, params[:document])
    File.write(file_path, '')
    session[:message] = "#{params[:document]} has been created."
    redirect '/'
  else
    session[:message] = 'Enter a valid extension (txt or md)'
    status 422
    erb :new
  end
end

post '/:filename' do
  file_path = File.join(data_path, params[:filename])

  File.write(file_path, params[:content])

  session[:message] = "#{params[:filename]} has been updated."
  redirect '/'
end

post '/:filename/delete' do
  file_path = File.join(data_path, params[:filename])
  File.delete(file_path)

  session[:message] = "#{params[:filename]} has been deleted."
  redirect '/'
end