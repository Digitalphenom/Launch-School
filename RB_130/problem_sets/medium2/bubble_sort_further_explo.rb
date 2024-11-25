def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1].downcase <= array[index].downcase
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

p array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)
p array# == %w(alice bonnie Kim Pete rachel sue Tyler)

# update this code so that you pass one value to the block and the method uses <= to compare two values which mutates the array and returns it sorted alphabetically from small to large chars

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# %w(sue Pete alice Tyler rachel Kim bonnie)
# %w(alice bonnie Kim Pete rachel sue Tyler)
# From looking at the test caes, it appears that we are arranging the array as if it were all lowercased without explicitly transforming each name. We simply use the return value of the method to compare names, but then swap them as they are.
