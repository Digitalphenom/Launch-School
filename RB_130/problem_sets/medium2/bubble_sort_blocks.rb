def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end

      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

puts "- Block Sorting"
puts "- Right Object greater than left"
p array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) do |first, second|
  first.downcase <= second.downcase
end

p array#
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

puts

puts "- Block Sorting"
p array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }

p array
p array == [14, 22, 12, 6, 27]

puts
puts "- Block Sorting"
array = [5, 3, 7]
p array# = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }

p array
p array == [7, 5, 3]

puts
puts "- Defaul Sorting"
p array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array# == %w(Kim Pete Tyler alice bonnie rachel sue)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

this problem requres us to modify an exisitng imlementation of bubble_sort so that we pass two values to a block and swap or not swap those values based on the return value of the block

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
[6, 12, 27, 22, 14]

block => { |first, second| (first % 7) <= (second % 7) }
 if first value modulo 7 is less than or equal second modulo 7
  swap otherwise skip

[14, 22, 12, 6, 27]

swap if left num is less than right num
skip if left num is greater than right num
[5, 3, 7]

[5, 3, 7]
[5, 7, 3]

[5, 7, 3] round 2
[7, 5, 3] round 2

[7, 5, 3] round 3

swap if left num is greater than right num
skip if left num is less than right num

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
=end
