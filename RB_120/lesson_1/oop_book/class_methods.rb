# Define a SushiLunchOrder class below.
#
# A SushiLunchOrder object should initialize with @salmon, @tuna,
# and @yellowtail instance variables from arguments to the
# initialize method. All values will be integers representing
# the number of that type of fish in the lunch order.
#
# Define getter methods for the 3 instance variables.
#
# Define a salmon_special class method that instantiates a
# SushiLunchOrder instance with 6 pieces of salmon, 3 pieces
# of tuna, and 3 pieces of yellowtail.
#
# Define a family_combo class method that instantiates a
# SushiLunchOrder instance with 12 pieces of salmon, 12 pieces
# of tuna, and 12 pieces of yellowtail.
#
# Define a total_pieces class variable that keeps track of
# the TOTAL number of pieces of fish that have been sold.
# This is not the number of SushiLunchOrder instances but rather
# the sum of all the parts of fish.
#
# Define a total_pieces class method that exposes the value of
# the total_pieces class variable.

class SushiLunchOrder
  @@total_pieces = 0

  def self.salmon_special
    SushiLunchOrder.new(6, 3, 3)
  end

  def self.family_combo
    SushiLunchOrder.new(12, 12, 12)
  end

  def self.total_pieces
    @@total_pieces
  end

  attr_reader :salmon, :tuna, :yellowtail
  
  def initialize(s, t, y)
    @salmon = s
    @tuna = t
    @yellowtail = y

    @@total_pieces += salmon + tuna + yellowtail
  end  
end

plate1 =  SushiLunchOrder.salmon_special
p plate1.salmon
p plate1.tuna
p plate1.yellowtail
puts
plate2 = SushiLunchOrder.family_combo
p plate2.salmon
p plate2.tuna
p plate2.yellowtail
puts
p SushiLunchOrder.total_pieces