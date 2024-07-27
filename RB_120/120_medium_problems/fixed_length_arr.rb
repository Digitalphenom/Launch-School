
# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

class FixedArray
  attr_reader :array_length

  def initialize(arg)
    @array_length = Array.new(arg)
  end

  def [](index)
    array_length.fetch(index)
  end

  def []=(index, arg)
    # self refers to the calling object and invokes `[]` as defined on the FixedArray class which weve repurposed to use `fetch`. if an argument error is raised it will be captured in our rescue. If it doesnt then this line returns whatever value and moves on to the next line which performs the mutating action were after. 
    self[index] 
    
    array_length[index] = arg
  end

  def to_a
    array_length.clone # we use clone to create a duplicate of the array instead of returning the original array. This prevents the outside program from mutating our array and changing the entire return values in our test cases.
  end

  def to_s
    to_a.to_s # We invoke `to_a` on the implicit receiver??
  end
end

fixed_array = FixedArray.new(5)

puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5
puts

fixed_array[3]=('a')
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]
puts

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]
puts

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]
puts

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'
puts

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'
puts 

begin
  puts fixed_array[6]
  puts false
rescue IndexError
  puts true
end
begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# This code utitlizes `rescue` to rescue an `IndexError` if one is raised. However, element reference returns `nil` when an out of bounds nil error is raised. Because of this `rescue` never executes, and `false` is output.

# To fix this we can call `fetch` which differentiates between a valid `nil` and an out of bounds `nil` by raising an `IndexError` if encountered. This would trigger the `rescue` and executes the corresponding code. `puts true`
