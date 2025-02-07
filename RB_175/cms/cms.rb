require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'erubi'
require 'erubi/capture_block'
#require 'minitest/autorun'


enable :sessions
set :session_secret, SecureRandom.hex(32)


helpers do
  def check_if_valid_document
    if session[:document]
      "#{session[:document]} does not exist"
    else
      ""
    end
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
    session[:document] = params[:filename]
    redirect '/'
  end
end




