def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given? 
        if yield(array[index - 1], array[index])
          array[index], array[index - 1] = array[index - 1], array[index]
          #swapped = true
        else
          next
        end
      end
      next if array[index - 1] <= array[index]
      array[index + 1], array[index] = array[index], array[index + 1]
      swapped = true
    end

    break unless swapped
  end
  p array
end


# Default behavior of bubble sort
#If the first of the two elements is greater than the second, then the two elements are swapped.

# What we need to implement
#Your task in this assignment is to modify #bubble_sort! so it takes an optional block that determines which of two consecutive elements will appear first in the results.

# If the default behavior is that >= == true
# therefore <= == false
# So 

# (sue Pete alice Tyler rachel Kim bonnie)

# sue Pete
# Pete alice
# alice Tyler
# Tyler rachel
# rachel Kim
# Kim bonnie

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

#array = [3, 5]
#p array.size.times { |i| bubble_sort!(array, i) }
#p array == [3, 5]
#

#array = %w(sue Pete alice Tyler rachel Kim bonnie)
#array.size.times do |i|
#  bubble_sort!(array, i)
#end
#p array
#puts# ["Kim", "Pete", "Tyler", "alice", "bonnie", "rachel", "sue"]
#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

# array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
# array.size.times { |i| bubble_sort!(array, i) }
# p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
# 
# array = [5, 3]
# array.size.times { |i| bubble_sort!(array, i) }
# p array == [3, 5]
# 
# 
# array = [6, 2, 7, 1, 4]
# array.size.times { |i| bubble_sort!(array, i) }
# p array == [1, 2, 4, 6, 7]

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
puts 



p array = %w(sue Pete alice Tyler rachel Kim bonnie)

puts "- Block Sorting"
puts "- Right Object greater than left"
bubble_sort!(array) do |first, second|
  #require 'pry'; binding.pry
  first.downcase <= second.downcase
end

array# == %w(alice bonnie Kim Pete rachel sue Tyler)
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

puts

array = [6, 12, 27, 22, 14]

puts "- Block Sorting"
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
# [6, 12, 27, 22, 14]


p array# == [14, 22, 12, 6, 27]
p array == [14, 22, 12, 6, 27]

#
puts
puts "- Block Sorting"
array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
# 5, 3, 7
# 5, 7, 3 
# 7, 5, 3 

p array# == [7, 5, 3]
p array == [7, 5, 3]

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

# array = [6, 2, 7, 1, 4]
# array.size.times { |i| bubble_sort!(array, i) }
# p array == [1, 2, 4, 6, 7]
# 
puts
puts "- Defaul Sorting"
array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array# == %w(Kim Pete Tyler alice bonnie rachel sue)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧


#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

#(0...arr.size - 1).each do |start_idx|
#  if block_given?
#    return_value = yield(arr[start_idx], arr[start_idx + 1])
#    if return_value
#      arr[start_idx], arr[start_idx + 1] = arr[start_idx + 1], arr[start_idx]
#    else
#      arr[start_idx + 1], arr[start_idx] = arr[start_idx], arr[start_idx +1]
#    end
#  elsif arr[start_idx] > arr[start_idx + 1]
#    arr[start_idx], arr[start_idx + 1] = arr[start_idx + 1], arr[start_idx]
#  end
#end
#p arr