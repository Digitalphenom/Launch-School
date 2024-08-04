require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a )
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todos.first, @list.first)
  end
  
  def test_last
    assert_equal(@todos.last, @list.last)
  end
  
  def test_shift
    assert_equal(@todos.first, @list.shift)
    assert_equal(@todos[1], @list.first)
  end

  def test_pop
    assert_equal(@todos.last, @list.pop)
    assert_equal(@todos[-2], @list.last)
  end

  def test_done_question
    assert_equal(false, @list.done?)

    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_add_type_error
    assert_raises(TypeError) { @list.add(25)}
    assert_raises(TypeError) { @list.add('Hello')}
  end

  def test_add_alias
    todo = Todo.new('Wash Car')
    @list.add(todo)
    @todos << todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) do 
      @list.item_at(@list.size + 1)
    end

    assert_equal(@todo3, @list.item_at(-1))
  end
  
  def test_mark_done_at
    assert_raises(IndexError) do 
      @list.mark_done_at(@list.size + 1)
    end

    assert_equal(true, @list.mark_done_at(-1))
    assert_equal(true, @todo3.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo1.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) do 
      @list.mark_undone_at(@list.size + 1)
    end

    @list.done!

    assert_equal(false, @list.mark_undone_at(-1))
    assert_equal(false, @todo3.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo1.done?)
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) do 
      @list.remove_at(@list.size + 1)
    end

    assert_equal(@todo3, @list.remove_at(-1))
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_list_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s )
  end

  def test_todo_to_s
    todo_one = '[X] Buy milk'
    todo_two = '[X] Clean room'
    todo_three = '[X] Go to gym'
    todos = [todo_one, todo_two, todo_three]
    @list.mark_all_done

    (0...@list.size).each do |index|
      assert_equal(todos[index], @todos[index].to_s)
    end
  end

  def test_all_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end

  def test_each
    result = []
    @list.each { |todo| result << todo }

    assert_equal(@todos, result)
  end

  def test_each_return_value
    each_return_value = @list.each {}

    assert_equal(@list, each_return_value)
  end

  def test_select
    @list2.add(@todo1)
    @list2.add(@todo2)
    @list2.add(@todo3)

    select1_return_value = @list.select { |todo| todo.title == "Clean room" }
    select2_return_value = @list2.select { |todo| todo.title == "Clean room" }
    
    assert_equal(select1_return_value, select2_return_value )
  end
end