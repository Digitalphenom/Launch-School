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

  def test_word_count
    @input.rewind
    expected_count = @input.read.split.count

    assert_equal(expected_count, @text.word_count)
  end

  def teardown
    @input.close
    puts "File closed? #{@input.closed?}"
  end

end