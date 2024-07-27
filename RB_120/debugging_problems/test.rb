def process_data
  raise "Error occurred" if rand < 0.5
  "Data processed successfully"
rescue => e
  e
end

result = process_data

case result
when StandardError
  puts "Caught an error: #{result.message}"
when String
  puts "Operation successful: #{result}"
else
  puts "Unexpected result: #{result.inspect}"
end
