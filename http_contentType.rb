require "socket"

server = TCPServer.open(8008)

def read_html
  # TODO:ここでhtmlファイルを読み込む
  begin
    file_content = File.read('./hello.html')
  rescue  => e
    puts e.message
  end
end


while true
  socket = server.accept
  request = socket.gets
  if request.include? "GET"
    body = read_html
    socket.puts ['HTTP/1.1 200
     OK',
     'Server: liblib',
     # Content-Typeをtext/plainに変更してみる
     'Content-Type: text/plain; charset=utf-8',
     "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
    socket.puts body
  end
  p 'socket close'
  socket.close
end
p "finish"
server.close
