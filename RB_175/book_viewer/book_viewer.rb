require "sinatra"
require "sinatra/reloader"
require "tilt/erb"

helpers do

  def add_tag(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end

  def chapters
    result = []
    toc = @toc_contents.split("\n")

    toc.size.times do |i|
      result << [[toc[i]], i += 1, File.read("data/chp#{i}.txt")]
    end

    result.map do |chapter, number, content|
      next if @search_term.empty?
      chapter = chapter.join

      [chapter, number, content] if content.include?(@search_term)
    end.compact
  end

  def render_result
    return nil if chapters.empty?
    
    chapters.each do |chapter, number, content|
      paragraphs = retrieve_paragraph(content)
      yield(chapter, number, paragraphs) if block_given?
    end
  end
  
  def retrieve_paragraph(content)
    content.split("\n\n").select do |paragraph|
      paragraph if paragraph.include? @search_term
    end
  end

  def highlight_term(paragraph, term)
    paragraph.gsub(term, %(<strong>#{term}</strong>))
  end
end


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
  redirect "/unknown" if number > 15 || number.zero?

  @title = "Chapter #{number}: #{chapter_name}"

  @toc_contents = File.read('data/toc.txt')
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end

get "/unknown" do
  "unknow chapter entered"
end

get "/search" do 
  @search_term = params["query"]
  erb :search
end