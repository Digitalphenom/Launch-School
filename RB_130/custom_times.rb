def times_like(int) 
  counter = 0

  until counter == (int)
    yield(counter)
    counter += 1
  end
  int
end
p times_like(5) { |value| puts value }