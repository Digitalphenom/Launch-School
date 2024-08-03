def each_like(arr)
  counter = 0

  loop do
    break if counter == arr.size
    yield(arr[counter])
    counter += 1
  end
  arr
end

arr = [1, 3, 5, 8]

p each_like(arr) { |element| puts element + 1}
