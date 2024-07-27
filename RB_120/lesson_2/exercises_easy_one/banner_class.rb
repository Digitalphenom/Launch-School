
class Banner
  attr_reader :message, :empty_line, :center

  def initialize(message)
    @message = message
    @center = "-" * (message.size + 2)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def empty_line
    "| " + " " * message.size + " |"
  end

  def horizontal_rule
    "+" + center + "+"
  end

  def message_line
    "| #{message} |"
  end
end

puts Banner.new("Hello, Sedrick!")
#puts banner
