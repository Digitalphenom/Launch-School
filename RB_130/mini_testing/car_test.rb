require 'minitest/autorun'

require_relative 'car'

class CarTest < Minitest::Test
  def setup
    @car1 = Car.new
    @car2 = Car.new
  end

  def test_car_exists
    assert(@car1)
  end

  def test_wheels
    assert_same(4, @car1.wheels)
  end

  def test_value_equality

    assert_equal(@car1, @car2)
    assert_same(@car1, @car2)
  end


end
