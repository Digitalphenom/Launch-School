require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'erubi'
require 'erubi/capture_block'
require 'minitest/autorun'

#configure do
  set :root, File.dirname(__FILE__)
#end

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
  File.readlines("files/#{doc}")
end
