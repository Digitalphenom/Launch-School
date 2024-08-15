def factorial_enum(n = Float::INFINITY)
  Enumerator.new do |y|
    (0..n).reduce(1) do |acc, i|
      if i.zero? || i == 1
        y << acc
        next acc
      end
      acc *= i
      y << acc
      acc
    end
  end
end

factorial_enum(7).each.with_index { |acc, i| puts "#{i}! #{acc}"}
enum = factorial_enum
puts

6.times { |i| puts "n!#{i} #{enum.next}"}
puts
6.times { |i| puts "n!#{i} #{enum.next}"}
puts
enum.rewind
6.times { |i| puts "n!#{i} #{enum.next}"}
