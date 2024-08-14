

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items, &block)
  puts "Let's start gathering food."
  block.call(items)
  puts "Nice selection of food we have gathered!"
end

gather(items) do |item|
  puts "#{items.join(', ')}"
end