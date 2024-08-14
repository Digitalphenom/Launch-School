def drop_while(collection)
  collection.each_with_object([]).with_index do |(element, result), i|
    return collection[i..-1] unless yield(element)
  end
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []


=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  Given an input array of numeric values place all remaining elements into a new array if a block returns false or nil.

  ▣ When a block evaluates to false or nil the current element upto the final element should be placed in a block
  ▣ If block evaluates to false for every iteration return empty array

  #⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

[1, 3, 5, 6] { value.odd?}
1 = true
3 = true
5 = true
6 = false => [6]

[1, 3, 5, 6] { value.even?}
1 = false => [1, 3, 5, 6]

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: Array
In-between: [] << element
Output: New array

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ ALgorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Access each element
    □ pass control to the block
      ﹥ If block evaluates to true
        - go next
      ﹥ If block evaluates to false or nil
        - get current element upto final element
        - Insert into new array [] << (current..end)
        - terminate loop & return new collection
=end

