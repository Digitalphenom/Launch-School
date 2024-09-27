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
    puts " - #{title} is done!"
    self.done = true
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
  attr_reader :list

  def initialize(title)
    @title = title
    @list = []
  end

  def <<(todo)
    unless todo.is_a?(Todo)
      raise TypeError, "Can Only add Todo objects!"
    else
      puts "Adding (#{todo.title}) item to list ..."
      @list << todo
    end
  end

  alias :add :<<

  def to_s
    if @list.empty?
      "Your list is empty"
    else
      todo_title = "---- #{title} ----\n"
      todos = @list.map { |todo| todo.to_s }.join("\n")
      todo_title + todos
    end
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
    "Item at position #{position + 1} is marked done."
    item_at(position).done!
  end

  def mark_undone_at(position)
    "Item at position #{position + 1} marked undone."
    item_at(position).undone!
  end

  def remove_at(position)
    @list.delete(item_at(position))
  end

  def each
    return self if self.list.empty?
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

  def ==(other)
    other.is_a?(TodoList) && self.size == other.size
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


list.mark_done_at(1)
puts list
#p list.item_at(-1)
#results = list.select { |todo| todo.done? }    # you need to implement this method
#p list.all_done
#p list.all_not_done
#puts results.inspect