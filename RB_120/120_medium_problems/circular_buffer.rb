# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# Given a collection of objects stored in a buffer, emulate the addition and subtraction of a buffer so that a `get` method removes (and returns) the earliest included value from the buffer. A `put` method should add a value to the buffer. If we call put and the buffer exceeds the maximum num of alloted elements, remove the earliest included element and add new element to the end of buffer

# ▣ The buffer should begin empty
# ▣ if we call `get` and the buffer is empty we return nil
# ▣ all values will be non nil values

# ▣ can obj be duplicate?
# ▣ are obj in order? ie integers 1, 2, 3 ...


# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# []
# puts(1)
# [1]
# puts(2)
# [1, 2]
# get # => 1
# [2]

# puts(5)
# [2,5]
# puts(6)
# [2,5, 6]
# puts(7)
# [(2),5, 6, 7]
# [5, 6, 7]
# get => 5
# [6, 7]
# get => 6
# [7]
# get => 7
# []
# get => nil
# [] 

# [nil, nil, nil, nil]
# put(1)
# [1]
# put(2)
# [1, 2]
# get => 1

# put(3)
# [2, 3]
# put(4)
# [2, 3, 4]
# get => 2
# [3, 4]
# put(5)
# [3, 4, 5]
# put(6)
# [6, 3, 4, 5]
# put(7)
# [6, 4, 5, 7]
# get => 4
# [5, 6, 7]
# get => 5
# [6, 7]
# get => 6
# [7]
# get => 7
# []
# get => nil
# []

# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DATA ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# initialize empty array when creating a new instance of buffer obj
# []
# Mutate array based on the put and get methods
# return array
# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# ▣ Define a CircularBuffer Class that takes a given set of arguments
#   □ the array is created when a new instance is instantiated
#   □ the arguments creates an array with a maximum number of alloted elements
#   □ if the number of alloted elements is exceeded the first element is removed and the input element is added to the end of array
# ▣ Define a GET instance method
#   □ removes the oldest element from array and returns it
# ▣ Define a PUT instance method
#   □ adds element to beginning of array
#   □ checks array to ensure it is not greater than the size of the initial argument.
#   □ if it exceeds in size, remove the oldest element from array
#  ▣ Track buffer position
#       □ How to track all elements and remove the last element regardless of what position in the array its in?
#   □ create an empty array
#   □ access buffer array and place index positions in track_array.
#   □ when you need to remove an element, remove the least in value index position. 
#   □ use that value to access and remove element from buffer arr using ele ref.
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
require 'pry'

class CircularBuffer
  attr_reader :buffer, :buffer_size, :buffer_slots
  def initialize(max)
    @buffer_size = max
    @buffer = []
    @buffer_slots = {}
  end
 
  def get
    return_earliest_buffer 
  end

  def return_earliest_buffer
    return nil if buffer.empty?
    remove_element = buffer_slots[buffer.min]
    buffer_slots.delete(remove_element)
    buffer.delete(remove_element)
    remove_element
  end

  def replace_earliest_buffer(num)
    return nil if buffer.empty?
    earliest_element = buffer[buffer_slots.values.min]
    buffer.delete(earliest_element)
    buffer << num
  end

  def track_buffer_slots(num)
    return @buffer_slots[num] = 1 if @buffer_slots.empty?
    min_value = @buffer_slots.values.min
    @buffer_slots[num] = min_value + 1
    @buffer_slots
  end

  def put(num)
    buffer << num
    if validate_buffer?
      track_buffer_slots(num)
      buffer
    else
      replace_earliest_buffer(num)
    end
  end
  
  def validate_buffer?
    buffer.size <= buffer_size
    binding.pry
  end 
  def to_s
    p buffer
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
buffer = CircularBuffer.new(3)

puts buffer.get == nil
buffer.put(1)
buffer.put(2)
puts buffer

puts buffer.get == 1
puts buffer
buffer.put(3)
buffer.put(4)
puts buffer
puts buffer.get == 2
 
buffer.put(5)
puts buffer
buffer.put(6)
puts buffer
puts buffer
# puts buffer.get == 5
# puts buffer.get == 6
# puts buffer.get == 7
# puts buffer.get == nil
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# buffer = CircularBuffer.new(4)
# puts buffer.get == nil
# 
# buffer.put(1)
# buffer.put(2)
# puts buffer.get == 1
# 
# buffer.put(3)
# buffer.put(4)
# puts buffer.get == 2
# 
# buffer.put(5)
# buffer.put(6)
# buffer.put(7)
# puts buffer.get == 4
# puts buffer.get == 5
# puts buffer.get == 6
# puts buffer.get == 7
# puts buffer.get == nil