require 'socket'

server = TCPServer.new("localhost", 3003)

def parse_line(request_line)
  method, param, http = request_line.split
  path, param = param.split("?")
  param_hsh = {}

  param.split("&").each do |element|
    key, value = element.split(/=/)
    param_hsh[key] = value
  end

  [method, path, param_hsh, http]
end

loop do 
  client = server.accept
  #client.puts "HTTP/1.1 200 OK\r\n\r\n"
  #client.puts "Content-Type: text/plain\r\n\r\n"

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  method, path, param_hsh, http = parse_line(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"

  client.puts "Method Type: #{method}\r\n\r\n"
  client.puts "Path: #{path}\r\n\r\n"
  client.puts "#{param_hsh}\r\n\r\n"
  client.puts "HTTP Version: #{http}\r\n\r\n"
  client.puts "</pre>"
  
  client.puts "<div>"
  client.puts "<h1>Counter</h1>"

  number = param_hsh["number"].to_i
  client.puts "<p>The current number is #{number}.</p>"

  client.puts "</div>"

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"

  client.puts "</body>"
  client.puts "</html>"
  
  client.close
end


#rolls = param_hsh["rolls"].to_i
#sides = param_hsh["sides"].to_i
#
#rolls.times do |i|
#  roll = rand(sides) + 1
#  client.puts "<p>", roll, "</p>"
#end