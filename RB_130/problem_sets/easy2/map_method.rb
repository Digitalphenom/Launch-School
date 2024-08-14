def map(collection, &block)
  collection.each_with_object([]) do |(element, value), result|
    result << block.call(element, value)
  end
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]
p map({1 => "A", 3 => "C", 4 => "E"}) { |key, value| [key, value] }# == [[1], [1, 2, 3], [1, 2, 3, 4]]