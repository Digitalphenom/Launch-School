require 'minitest/autorun'

require_relative 'cash_register.rb'
require_relative 'transaction.rb'

class TransactionTest < Minitest::Test
  def setup
    @input = StringIO.new("25\n")
    @transaction = Transaction.new(25)
  end

  def test_prompt_for_payment
    @transaction.prompt_for_payment(input: @input)
    paid = @transaction.amount_paid

    @input.rewind
    assert_equal(@input.gets.to_f, paid)
  end

end