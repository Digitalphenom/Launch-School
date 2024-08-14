def max_by(collection, &block)
  current_value = 0

  hash_table(collection, &block).each do |_, value|
    current_value = value if value.abs > current_value
  end.key(current_value)
end

def hash_table(collection, &block)
  collection.each_with_object({}) do |element, hsh|
  hsh[element] = block.call(element).ord
  end
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil


=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Given an input array, return the element for which the block returns the largest value.

  ▣ If input array is empty return nil
  ▣ Assume all elements are integers?
  ▣ If element is an array pass to block
  ▣ if you encounter strings convert to digits
  ▣ 

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

[1, 5, 3] { |value| value + 2 } [3, 7, 6] => 5

[1, 5, 3] { |value| 9 - value } [8, 4, 6] => 1

[1, 5, 3] { |value| (96 - value).chr ['-', '[', ']' ]

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: Array
  Hash of digits & return values {element => block return value} => retrieve key with the highest value.
Output: Digit or nil

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algortithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  ▣ Return nil if empty collection input

  ▣ Access each element & pass to block
  ▣ capture return value from block as a hash key/value pair
    □ insert current element as key, block return as value
    □ Convert value into digit before adding to hash
    □ repeat for all elements
    {key, value }

  ▣ access each hash value
    □ Convert hash value to digit
    □ place value in variable
    □ Compare next hash value with current value
    □ If new value is greater re-asssign
    □ Else go next

  ▣ Return variable by passing to hash to retrieve correspoding value.

=end
