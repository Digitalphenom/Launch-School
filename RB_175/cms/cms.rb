require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'erubi'
require 'erubi/capture_block'
require 'redcarpet'
# require 'minitest/autorun'

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test", __FILE__)
  else
    File.expand_path("../files", __FILE__)
  end
end

helpers do
  def error_or_blank
    session[:error] || ''
  end

  def saved_changes
    session[:message] || ''
  end
end

def render_md(contents)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  contents.map { |line| markdown.render(line) }
end

def load_file_content(contents, doc)
  file_type = doc.split('.').last

  case file_type
  when 'md'
    headers['Content-Type'] = 'text/html'
    render_md(contents)
  when 'txt'
    headers['Content-Type'] = 'text/plain'
    contents
  end
end

get '/' do
  root = File.expand_path(__dir__)
  @files = Dir.glob(root + '/files/*').map do |path|
    File.basename(path)
  end
  erb :index
end

get '/:filename' do
  doc = params[:filename]
  begin
    contents = File.readlines("files/#{doc}")
    load_file_content(contents, doc)
  rescue Errno::ENOENT
    session[:error] = "#{params[:filename]} does not exist"
    redirect '/'
  end
end

get '/:filename/edit' do 
  doc = params[:filename]
  @contents = File.readlines("files/#{doc}")
  
  @file_name = params[:filename]
  erb :edit
end

post '/:filename' do
  file_name = params[:filename]
  File.open("files/#{file_name}", 'w') do |file|
    file.write params[:user_input]
  end

  session[:message] = "#{params[:filename]} has been updated."
  redirect '/'
end
