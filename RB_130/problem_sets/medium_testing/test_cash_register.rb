require 'minitest/autorun'
require_relative 'cash_register.rb'
require_relative 'transaction.rb'

class CashRegisterTest < MiniTest::Test
  def setup
    @cash_register = CashRegister.new(500)
    @transaction = Transaction.new(10)
  end

  def test_accept_money
    @transaction.amount_paid = 10

    previous_amount = @cash_register.total_money
    @cash_register.accept_money(@transaction)
    current_amount = @cash_register.total_money

    assert_equal(previous_amount + 10, current_amount)
  end

  def test_change
    transaction = @transaction.amount_paid = 20
    item_cost = @transactiolsn.item_cost
    expected_change = transaction - item_cost
    actual_change = @cash_register.change(@transaction)

    assert_equal(expected_change, actual_change)
  end

  def test_give_receipt
    cash_register = CashRegister.new(0)
    transaction = Transaction.new(125)

    cost = transaction.item_cost
    expected_value = "You've paid $#{cost}.\n"

    assert_output(expected_value, nil) do 
      cash_register.give_receipt(transaction)
    end
  end
end
