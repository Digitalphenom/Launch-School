require 'minitest/autorun'

require_relative 'easy_testing_file'

class EasyTest < MiniTest::Test

  def setup

  end

  def test_odd_question_mark
    value = 1
    assert(value.odd?)
  end

  def test_downcase
    value = "XYZ"
    assert_equal("xyz", value.downcase)
  end
  
  def test_nil
    value = nil
    assert_nil(value)
  end

  def test_list
    list = []
    assert_empty(list)
  end
  
  def test_value_in_list
    list = ["joe", "shmoe", 'xyz']
    assert_includes(list, 'xyz')
  end

  def test_no_experience_error
    joe = Employee.new('Joe', 1)
    assert_raises(NoExperienceError) do 
      joe.hire
    end
  end

  def test_instance_of
    value = 5
    assert_instance_of(Integer, value)
  end

  def test_kind_of
    value = 5.5
    value2 = 5
    assert_kind_of(Numeric, value)
    assert_kind_of(Numeric, value2)
  end

  def test_process
    list = Documents.new("mike")

    assert_same(list, list)
  end

  def test_futations
    list = ["joe", "shmoe"]

    refute_includes(list, "xyz")
  end
end