
=begin
Given the following code, complete it so that it outputs:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.

=end

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# The main difference bettwen initializing objects in this way vs using the initialize method is that we give control to the user to add or remove values which might not be favorable because it can lead to unintended changes to the code. Using the initialzise method which is private, may allow for better encapsulation of code by controlling the initial state an object holds.
