    # if total contains 2 aces, replace the value of one ace with 1 leave the other as is. [11, 11] => [11, 1]
    # if deck contains ONE ACE, do nothing.
    # If card contains one ace and 2 or more of any other cardk, remove ace, get total. If total is less than 11 insert 11 back into deck. 
    # [11, 10, 10] 31 => [1, 10, 10]
    # [4, 2, 9, (11)] 15 => [4, 2, 9, 1]
    # [2, 2, 6, (11)] 10 => [2, 2, 6, 11]
    # [2, 7, 10, 10]  => [2, 7, 10, 10]
      # if equal of greater than 11 insert 1
      # if no aces are contain do nothing.
    #@total.count == 2 && count == 1


    # [11, 10, 10] 31 => [1, 10, 10]
    # [4, 2, 9, (11)] 15 => [4, 2, 9, 1]
    # [2, 2, 6, (11)] 10 => [2, 2, 6, 11]
    # [2, 7, 10, 10]  => [2, 7, 10, 10]
class Test
  attr_accessor :total
  def initialize(arr)
    @total = arr
  end

  def eleven_or_one
    arr = @total[0...@total.size - 1]

    @total[-1] = 1 if @total.last == 11 && arr.sum >= 11
    @total
  end
end

 #count > 1 && @total.sum >= 11
# arr.delete(11)
#        if arr.sum < 11 
#         @total
#        else
#         @total.delete(11)
#         @total << 1
#         @total
#        end

obj0 = Test.new([11, 11]) # => [10, 10, 1] => 21
#obj1 = Test.new([11, 10, 10]) # => [10, 10, 1] => 21
#obj2 = Test.new([4, 2, 9, (11)]) # => [4, 2, 9, 1]
#obj3 = Test.new([2, 2, 6, (11)]) # => [2, 2, 6, 11]
obj4 = Test.new([8, 2, 4, 11]) # => [9, 11, 1, 9]

# If the sum of the array is greater than or equal to 11 and theres more than one 11

# Your first init check should ensure that there is no double ACE replace to 1 if true.
# after each hit, check card stack to see if it is greater than or equal to 11. If it is and the new card is 11 replace it with 1 else leave as is.

p obj0.eleven_or_one
# p obj1.eleven_or_one
# p obj2.eleven_or_one
# p obj3.eleven_or_one
p obj4.eleven_or_one

# refactored to remove unneccesary return of @total and updated sum criterai to greater or equal than 11.

# def eleven_or_one
#   count = @total.count { |value| value == 11 }
#   arr = @total.dup
# 
#   if count == 2
#     @total.pop
#     @total << 1
#   elsif count == 1 && @total.size > 2
#     arr.delete(11)
#      if arr.sum >= 11 
#       @total.delete(11)
#       @total << 1
#      end
#   end
# end

# [11, 1, 11]
  # => [11, 1, (11)] 12
  # => [11, 1, 1] 13