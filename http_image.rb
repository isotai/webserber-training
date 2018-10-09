require "socket"

server = TCPServer.open(8008)

def read_image
    img = File.open('./lib.png', 'rb') {|file| file.read }
end

while true
　socket = server.accept
  request = socket.gets
  if request.include? "GET"
    image = read_image
    image_length =  image.length
    p image_length
    reduced_leng = image_length - 20000
    p reduced_leng
    socket.puts ['HTTP/1.1 200 OK',
                   'Server: liblib',
                   'Content-Type: image/png; charset=utf-8',
                   "Content-Length: '#{image_length}\r\n\r\n"].join("\r\n")
    socket.puts image
  end
  p 'socket close'
  socket.close
end
p "finish"
server.close