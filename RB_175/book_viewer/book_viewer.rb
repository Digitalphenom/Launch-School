require "sinatra"
require "sinatra/reloader"
require "tilt/erb"

get "/" do
  @contents = File.read("data/toc.txt")
  erb :home
end

get "/chapters/1" do 
  @title = "Chapter 1"
  @toc_contents = File.read('data/toc.txt')
  @chapter_contents = File.read('data/chp1.txt')

  erb :chapter
end