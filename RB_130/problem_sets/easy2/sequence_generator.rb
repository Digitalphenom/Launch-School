def step(start_step, end_step, step)
  range = (start_step..end_step).to_a
  count = 0
  result = []
  step_count = step

  loop do 
    if count == 0 || count == step_count || count == range.size - 1
      yield(range[count]) 
      result << range[count]
      break if count == range.size - 1
      step_count += step  if count == step_count
      count += 1
      next
    end
    count += 1
  end
  return result if step_count == 1 ||result.size % step_count - 1 == 0
  result[0..-2]
end

p step(1, 1558, 72) { |value| puts "value = #{value}" }

# value = 1
# value = 4
# value = 7
# value = 10

# generate a sequence of digits from start to end
# iterate through sequence in steps of input step
# [1, 2, 3, 4, 5, 6, 7]
# begin with starting count and count the number of steps and then add 1
# yield the starting count each step count and the final count to the block
#(1), 2, 3, (4), 5, 6, (7), 8, 9, (10)
#(1), 2, (3), 4, (5), 6, (7), 8, (9), (10)

#(1), 2, 3, 4, (5), 6, (7)

# LS solution
def step(start_point, end_point, increment)
  current_value = start_point
  loop do
    yield(current_value)
    break if current_value + increment > end_point
    current_value += increment
  end
  current_value
end