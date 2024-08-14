require 'minitest/autorun'
require_relative 'cash_register.rb'
require_relative 'transaction.rb'

class CashRegisterTest < MiniTest::Test
  def setup
  end

  def test_accept_money
    cash_register = CashRegister.new(500)
    transaction = Transaction.new(10)
    transaction.amount_paid = 10

    previous_amount = cash_register.total_money
    cash_register.accept_money(transaction)
    current_amount = cash_register.total_money

    assert_equal(previous_amount + 10, current_amount)
  end
end