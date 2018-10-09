require "socket"

server = TCPServer.open(8008)

while true
  socket = server.accept
  while buffer = socket.gets
    p buffer
    socket.puts "200"
  end
  p 'socket close'
  socket.close
end
p "finish"
server.close