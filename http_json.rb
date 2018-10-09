require "socket"

server = TCPServer.open(8008)

def read_json
  # ファイルを読み込む
  begin
    file_content = File.read('./content.json')
  rescue  => e
    puts e.message
  end
end

while true
  socket = server.accept
  request = socket.gets
  if request.include? "GET"
    body = read_json
    socket.puts ['HTTP/1.1 200 OK',
                   'Server: liblib',
                   'Content-Type: application/json; charset=utf-8',
                   "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
    socket.puts body 
  end
  p 'socket close'
  socket.close
end
p "finish"
server.close