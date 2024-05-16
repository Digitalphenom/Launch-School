=begin

# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# Given a collection of objects stored in a buffer, emulate the addition and subtraction of a buffers element so that a `get` method removes (and returns) the earliest included element from the buffer. A `put` method should add a value to the buffer. If we call put and the buffer exceeds the maximum num of alloted elements, remove the earliest included element and add new element to the end of buffer

# ▣ The buffer should begin empty
# ▣ if we call `get` and the buffer is empty we return nil
# ▣ all values will be non nil values

# ▣ can obj be duplicate?
# ▣ are obj in order? ie integers 1, 2, 3 ...

=end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class CircularBuffer

  def initialize(max)
    @max_buffer_size = max
    @buffer = {}
    @count = 1
  end
 
  def get
    remove_earliest_obj()
  end

  def put(num)
    @buffer[num] = @count
    @count += 1
    remove_earliest_obj() if validate_buffer?
  end

  def remove_earliest_obj
    min_obj = @buffer.key(buffer.values.min)
    @buffer.delete(min_obj)
  end

  def validate_buffer?
    buffer.size > @max_buffer_size
  end

  def to_s
    p @buffer
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
buffer = CircularBuffer.new(3)

puts buffer.get == nil
buffer.put(1)
puts buffer
buffer.put(2)
puts buffer
puts
puts buffer.get == 1
puts buffer
puts
buffer.put(3)
buffer.put(4)
puts buffer
puts buffer.get == 2
puts buffer
buffer.put(5)

puts('---------------□□-----------')
puts buffer
buffer.put(6)# greater than size
puts 'added 6 should replace 3'
puts buffer
buffer.put(7)
puts buffer.get == 5
puts buffer

puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
buffer = CircularBuffer.new(4)
 puts buffer.get == nil
 
 buffer.put(1)
 buffer.put(2)
 puts buffer.get == 1
 
 buffer.put(3)
 buffer.put(4)
 puts buffer.get == 2
 
 buffer.put(5)
 buffer.put(6)
 buffer.put(7)
 puts buffer.get == 4
 puts buffer.get == 5
 puts buffer.get == 6
 puts buffer.get == 7
 puts buffer.get == nil