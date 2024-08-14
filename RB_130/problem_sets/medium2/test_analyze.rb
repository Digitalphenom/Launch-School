class TextAnalyzer
  def process
    file = File.open('analyzer.txt')
    yield(file.read) if block_given?
    file.close
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

analyzer = TextAnalyzer.new

analyzer.process do |docs|
  puts "#{docs.split(/\.(?=\n)/).size} paragraphs"
end

analyzer.process do |docs|
  puts "#{docs.to_s.split("\n").size} Lines"
end

analyzer.process do |docs|
  puts "#{docs.split.size} Words"
end
