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

def read_js
  # TODO:ここでhtmlファイルを読み込む
  begin
   file_js_content = File.read('./im_here.js')
  rescue  => e
    puts e.message
  end
end


while true
  socket = server.accept
  request = socket.gets

  break unless request.include? "GET"

  if request.include? "js"
     puts request
     body = read_js
     socket.puts ['HTTP/1.1 200 OK',
                   'Server: liblib',
                   'Content-Type: text/javascript; charset=utf-8',
                   "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
     socket.puts body
  elsif request.include? "ajax"
     puts request
     body ="ajax done"
     socket.puts ['HTTP/1.1 200 OK',
                   'Server: liblib',
                   'Content-Type:text/plain; charset=utf-8',
                   "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
     socket.puts body
  elsif
    body = read_html
    socket.puts ['HTTP/1.1 200 OK',
                   'Server: liblib',
                   'Content-Type: text/html; charset=utf-8',
                   "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
    socket.puts body
    p 'socket close'
    socket.close
  end
end
p "finish"
server.close
