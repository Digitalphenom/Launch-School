require 'minitest/autorun'

require_relative 'text_swap.rb'

class TextTest < MiniTest::Test
  def setup
    @input = File.open('sample.txt')
    @text = Text.new(@input.read)

  end

  def test_swap
    swapped_text = @text.swap('a', 'e')
    @input.rewind
    expected_text = @input.read.gsub('a', 'e')

    assert_equal(expected_text , swapped_text)
  end

  def teardown
    @input.close
  end

end