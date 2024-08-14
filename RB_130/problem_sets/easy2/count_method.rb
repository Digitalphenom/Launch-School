
def count(*args, &block)
  args.reduce(0) do |acc, (element, value)|
    block.call(element,value) ? acc += 1 : acc
  end
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count(1, 3, 6) { |value| value - 6 } == 3
p count() { |value| true } == 0