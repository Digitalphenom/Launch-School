require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'erubi'
require 'erubi/capture_block'


get '/' do
  root = File.expand_path('..', __FILE__)
  @files = Dir.glob(root + '/files/*').map do |path|
    File.basename(path)
  end
  erb :index
end

get '/:filename' do
  headers 'Content-Type' => 'text/html'

  doc = params[:filename]
  
  File.readlines("files/#{doc}")
end
