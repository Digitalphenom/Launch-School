require "sinatra"
require "sinatra/reloader"
require "tilt/erb"


get "/" do 
  docs = Dir.new("./public/docs")

  @links = docs.each_with_object([]) do |d, arr|
    next if d.match?(/^\./)
    arr << " <a href=/docs/#{d}>#{d}</a>"
  end
  @links.reverse! if params[:sort] == "desc"
  erb :template
end

get "/docs/chp1.txt" do
  File.read "/docs/chp1.txt"
end

get "/docs/chp2.txt" do
  File.read "/docs/chp2.txt"
end

get "/docs/chp3.txt" do
  File.read "/docs/chp3.txt"
end