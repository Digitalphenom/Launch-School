require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'erubi'
require 'erubi/capture_block'
#require 'minitest/autorun'

enable :sessions
set :session_secret, SecureRandom.hex(32)

helpers do
  def error_or_blank
    session[:error] ? session[:error] : ""
  end
end

get '/' do
  root = File.expand_path('..', __FILE__)
  @files = Dir.glob(root + '/files/*').map do |path|
    File.basename(path)
  end
  erb :index
end

get '/:filename' do
  headers 'Content-Type' => 'text/plain'
  doc = params[:filename]
  begin
    File.readlines("files/#{doc}")
  rescue StandardError
    session[:error] = "#{params[:filename]} does not exist"
    redirect '/'
  end
end




