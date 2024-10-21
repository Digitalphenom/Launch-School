=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


take a string and return all possible consecutive numbers based on a specified length

  ▣ explicit req
    □ should contain a sequence of values of specified length or slices
    □ input slice should be less than or equal to size of string
    □ raise argument error if greater

  ▣ implicit req
    □ reuturn a multi dimensional array
      [[], [], []]
    □ begin slicing from 0 upto slice 
      ﹥ then go next

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


'01234' slice 1
(0 1 2 3 4)

'01234' series.slices(2)
[0, 1], [1, 2], [2, 3], [3, 4]]

31001' slices(3)
[[3, 1, 0], [1, 0, 0], [0, 0, 1]],


01032987583 series.slices(slice_string.length + 1)
argument error

('91274')
(9127)4,
[9, 1, 2, 7]
9(1274)
[1, 2, 7, 4]

[[9, 1, 2, 7], [1, 2, 7, 4]], series.slices(4)

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
input: string number sequence
      intermediary:
      get length
      slice from left to right while length is less than or equal to slice count
      place in array
      return
output: multi array of slices

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Al ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
▣ Create series class
    □ define constructor
    □ accept input string

▣ define slices im
    □ accept arg slice count
    □ get input string length
      ﹥ from 0 upto length slice
        -access series string [0..length]
        - length is variable, meaning that it must be incremented along with the next iteration
          => (0..3) => (0..3)
          => (1..3) => (1..4)
          => (2..3) => (2..5)
          => (3..3) => (3..6)
        -place in array
      ﹥repeat with next char
        - break if nil values are returned
      ﹥ return array
=end

class Series
  attr_reader :series

  def initialize(series)
    @series = series
  end

  def slices(slice_count)
    raise ArgumentError if slice_count > series.length
    to = slice_count
    
    (0..series.length).each_with_object([]) do |from, arr|
      return arr if series[from..to].length < slice_count

      arr << series[from...to].chars.map(&:to_i)
      to += 1
    end
  end
end