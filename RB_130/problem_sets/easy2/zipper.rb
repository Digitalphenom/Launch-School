
def zip(arr1, arr2)
  result = []

  (0...arr1.size).each do |outer_i|
    result << [arr1[outer_i], arr2[outer_i]]
  end
  result
end

p zip([1, 2, 3], [4, 5, 6])# true [[1, 4], [2, 5], [3, 6]]

=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# Given an input value of 2 arrays, return a new array where each value of each array are placed into a new nested array. Each value should be identical in terms of index position

  ▣ Assume that your dealing with even numbered arrays
  ▣ Method should require only 2 arguments in form of array
  ▣ input arrays should not be modified
  ▣ Method should return a new array containing nested sub-arrays

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# arr1[1, 2, 3, 5, 6]
# arr2[1, 8, 7, 51, 16]
# [1,1], [2, 8], [3, 7], [5, 51] and so forth..

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: Array
Intermediary: nested_iteration => sub-arrays
Output: Array of sub-arrays

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Access first element from first array
    □ Place first element into sub-array
  ▣ Access first element from second array
    □ Place second element into sub-array
  ▣ Place each sub-array into new collection
  ▣ Repeat
  ▣ Return Collection
=end

