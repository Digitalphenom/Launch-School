def any?(input_arr)
  input_arr.each do |num, value|
    boolean = yield(num, value) if block_given?
    return true if boolean
  end
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false

p any?({1 => "a", 3 => "c", 6 => "e", 7 => "g"}) { |key, value| key == 5 && value == "e" }
#p any?([]) { |value| true } == false