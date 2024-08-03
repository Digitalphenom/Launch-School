def reduce(arr, acc = 0)
  if arr.any? { |el| el.is_a?(String)}
    arr = arr.map { |el| el.to_s}
    acc = ''
  elsif arr.any? { |el| el.is_a?(Array)}
    arr = arr.map { |sub_arr| sub_arr.map { |el| el.to_s}}
    acc = []
  end

  counter = 0

  loop do 
    begin
    return_value = yield(acc, arr[counter])
    acc = return_value
    counter += 1
    break if counter == arr.size
    rescue NoMethodError => e
      print 'Incorrect implementation '
      puts e.message
      break
    end
  end

  if acc.is_a?(Array)
    acc.map { |el| el.match?(/[0-9]/) ? el.to_i : el } 
  else
    acc
  end
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
 reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']