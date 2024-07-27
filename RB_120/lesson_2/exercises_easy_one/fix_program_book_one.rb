
=begin
Given the following code, complete it so that it outputs:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# to get the output we want in this code all we need to add is two getter methods in the form of `attr_reader` so that we can access the values contained within `@author` & `@title` when we call `title` and `author` on an instance of `book`.

# the attr_* syntax methods is shorthand for creating getter, setter and getter/setter methods without having to manually define them. `attr_reader` allows a user to access the value of an instance variable, `attr_writer` allows the user to update the values an instance variable holds and the attr_accessor combines both a `getter` and `setter` method in one.

# changing the code to a manually defined getter methods will not alter the functionality of this code, other than allow space for adding additional logic to the getter methods.