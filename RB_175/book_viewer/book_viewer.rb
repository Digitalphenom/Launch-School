require "sinatra"
require "sinatra/reloader"
require "tilt/erb"

before do
  @toc_contents = File.read("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do 
  number = params[:number].to_i

  chapter_name = @toc_contents.split(/\n/)[number - 1]
  @title = "Chapter #{number}: #{chapter_name}"

  @toc_contents = File.read('data/toc.txt')
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end
