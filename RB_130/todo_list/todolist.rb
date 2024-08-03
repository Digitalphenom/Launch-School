# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
    puts " - #{title} is done!"
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class TodoList 
  attr_accessor :title
  attr_reader :todo_list

  def initialize(title)
    @title = title
    @list = []
  end

  def add(todo)
    unless todo.is_a?(Todo)
      raise TypeError, "Can Only add Todo objects!"
    else
      puts "Adding (#{todo.title}) item to list ..."
      @list << todo
    end
  end

  def to_s
    if @list.empty?
      puts "Your list is empty"
    else
    "---- #{title} ----"
    @list.each { |todo| puts todo }
    end
    ""
  end

  def size
    @list.size
  end

  def first
    @list.first
  end

  def last
    @list.last
  end

  def to_a
    @list.clone
  end

  def done?
    @list.all? { |todo| todo.done? }
  end

  def done!
    @list.map { |todo| todo.done! }
    "Your list is done!"
  end

  def shift
    @list.shift
  end

  def pop
    @list.pop
  end

  def item_at(position)
    @list.fetch(position)
  end

  def mark_done_at(position)
    item_at(position).done!
    "Item at position #{position + 1} is marked done."
  end

  def mark_undone_at(position)
    item_at(position).undone!
    "Item at position #{position + 1} marked undone."
  end

  def remove_at(position)
    @list.delete(item_at(position))
  end

  def each
    counter = 0

    loop do 
      yield(@list[counter])
      counter += 1
      break if counter == @list.size
    end
    self
  end

  def select
    obj = TodoList.new(title)

    each do |ele|
      return_value = yield(ele)
      obj.add(ele) if return_value
    end
    obj
  end

  def find_by_title(title)
    each { |todo| return todo if title == todo.title }
    nil
  end

  def all_done
    select { |todo| todo.done?}
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    each do |todo|
      return todo.done! if !todo.done? && todo.title == string 
    end
  end

  def mark_all_done
    done! unless done?
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todo List")

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

list.add(todo1)
list.add(todo2)
list.add(todo3)
puts

todo1.done!
todo2.done!
todo3.done!
list.mark_all_undone
puts
 list.each {|todo| puts todo}
#results = list.select { |todo| todo.done? }    # you need to implement this method
puts
#p list.all_done
puts
#p list.all_not_done
#puts results.inspect