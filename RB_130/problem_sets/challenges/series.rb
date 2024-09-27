
=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

 given an input string of numeric values and an input number that represents a slice, return an array of sub_arrays that contain the numeric string sliced at the specified input slice

  ▣ Explicit Requirements
    □ Return array of sub array
      □ sub-array contains a slice sequence
    □ If slice input is greater than string input raise Arg Error
    □ Sub-arr slice size should not exceed input slice number
      □ if the slice count slices all input chars evenly end slicing
        '123' 3 => (123)
        
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
        
  '123' 3 => (123) [[1,2,3]]
  0123 = 2
  (01) => [[0,1]]
  (23) => [[0,1], [2, 3]]
  123456 => 5
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: String of numeric vals 
Input: Integer representing amount of slices
  How to access character slices possible to convert string into array of chars or deal with string directly then convert it into an array of sub-array
Output: Nested Array => [[slices]]

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  ▣ Create Series class
    □ Capture its argument in a input string iv
  ▣ define a slices instance methods that takes a slice as an argument.

  ▣ If slice count is greater than input string raise Arg Error
  ▣ Access input numeric string chars beginning from the first char
  upto the specified slice.
    □ '123' => (12)3   
  ▣ Place each range of slices into a new array
    □ [[1,2]] << (1,2)
  ▣ Continue with subsequent char upto specified slice
    □ '123' => 1(23) 
    □ [[1,2], [2,3]] << (1,2)
  ▣ If an out of bound nil error is encountered
    stop.
    □ (3, nil)

  ▣ Return the array
=end

class Series
  attr_reader :input_str

  def initialize(input_str)
    @input_str = input_str.chars
  end

  def slices(slice)
    raise ArgumentError if slice > input_str.size
    
    (0..input_str.size - slice).each.with_object([]) do |idx, result|
      result << input_str[idx, slice].map(&:to_i)
      #slice += 1
      #break result if slice > input_str.size 
    end
  end
end
