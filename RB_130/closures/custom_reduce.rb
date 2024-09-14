# the reduce method when called on an array of numeric values, passes the current vlaue along with an accumulator to the block. Within the block, the blocks return value is assigned to the accumulator and carried to the next iteration. After the method executes, it returns the accumulator.

# the reduce method takes an optionally argument which specifies the accumulator starting value. 

# if a value is not passed then we default to using the first element in the collection and begin from the second element.


def reduce(obj, default = nil)
  if default.nil?
    acc = obj.first
    obj = obj[1..-1]
  else
    acc = default
  end

  obj.each do |value|
    acc = yield(acc, value) 

  end
  acc
end

array = [1, 3, 4, 8, 5]
nested_arr = [[1, 3], [4, 8], [5]]
string = %w(joe is a hoe)

result = reduce(array) do |acc, value|
  acc += value + 1
end

p result

result = reduce(nested_arr, [1]) do |acc, sub_arr|
  acc += sub_arr
end
p result

result = reduce(string) do |acc, word|
  acc += word
end

p result

result = reduce(['a', 'b', 'c']) { |acc, value| acc += value }
p result

result = reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }
p result