class Wallet
  
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected
  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)

if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# inorder to encapsulate the amount of money in the Wallet class so that it is not accessible outside of the class, but can still be called on an instance of Wallet. We must set the `amount` getter method to protected. The protected keyword works similar to the private keyword in that it precvents access from outside the class, but it differs by allowing access between instances from within the class.
