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

class TodoList 
  attr_accessor :title
  attr_reader :todo_list

  def initialize(title)
    @title = title
    @todo_list = []
  end

  def add(todo)
    unless todo.is_a?(Todo)
      raise TypeError, "Can Only add Todo objects!"
    else
      puts "Adding (#{todo.title}) item to list ..."
      @todo_list << todo
    end
  end

  def to_s
    if @todo_list.empty?
      puts "Your list is empty"
    else
    "---- #{title} ----"
    @todo_list.each { |todo| puts todo }
    end
    ""
  end

  def size
    @todo_list.size
  end

  def first
    @todo_list.first
  end

  def last
    @todo_list.last
  end

  def to_a
    @todo_list.clone
  end

  def done?
    @todo_list.all? { |todo| todo.done? }
  end

  def done!
    @todo_list.map { |todo| todo.done! }
    "Your list is done!"
  end

  def shift
    @todo_list.shift
  end

  def pop
    @todo_list.pop
  end

  def item_at(position)
    @todo_list.fetch(position)
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
    @todo_list.delete(item_at(position))
  end

  def each
    counter = 0

    loop do 
      yield(@todo_list[counter])
      counter += 1
      break if counter == @todo_list.size
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
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todo List")

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect