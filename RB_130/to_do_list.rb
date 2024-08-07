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

  def initialize(title)
    @title = title
    @todo_list = []
  end

  def add(todo)
    unless todo.is_a?(Todo)
      raise TypeError, "Can Only add Todo objects!"
    else
      puts "Adding todo to list ..."
      todo_list << todo
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
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todo List")

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
#list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----

# size
list.size                       # returns 3

# first
list.first                      # returns todo1, which is the first item in the list

# last
list.last                       # returns todo3, which is the last item in the list

#to_a
list.to_a                      # returns an array of all items in the list

#done?
list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
#list.item_at                    # raises ArgumentError
list.item_at(1)                 # returns 2nd item in list (zero based index)
list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
#list.mark_done_at               # raises ArgumentError
list.mark_done_at(1)            # marks the 2nd item as done
#list.mark_done_at(100)          # raises IndexError

# mark_undone_at
#list.mark_undone_at             # raises ArgumentError
list.mark_undone_at(1)          # marks the 2nd item as not done,
#list.mark_undone_at(100)        # raises IndexError

# done!
list.done!                      # marks all items as done

# ---- Deleting from the list -----

# shift
list.shift                      # removes and returns the first item in list

# pop
list.pop                        # removes and returns the last item in list

# remove_at
#list.remove_at                  # raises ArgumentError
#list.remove_at(1)               # removes and returns the 2nd item
#list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym