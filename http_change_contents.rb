require "socket"

server = TCPServer.open(8008)

def read_html
  # TODO:ここでhtmlファイルを読み込む
  begin
     File.read('./hello.html')
  rescue  => e
    puts e.message
  end
end

def read_image
    File.open('./lib.png', 'rb') {|file| file.read }
end

def read_json
    # ファイルを読み込む
    begin
      File.read('./content.json')
    rescue  => e
      puts e.message
    end
end


# /img /json /html

while true
  socket = server.accept
  request = socket.gets
  body = nil
  content_type = nil

  # mapping start -->
  break unless request.include? "GET"
  if request.include? "/html"
    body = read_html
    content_type = 'text/html;'
  elsif request.include? "/json"
    body = read_json
    content_type = 'application/json;'
  elsif request.include? "/img"
    body = read_image
    content_type = 'image/png;'
  end
  #<-- mapping done
p body
    socket.puts ['HTTP/1.1 200
     OK',
                   'Server: liblib',
                   # Content-Typeをtext/plainに変更してみる
                   "Content-Type: #{content_type} charset=utf-8",
                   "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
    socket.puts body

  p 'socket close'
  socket.close
end
p "finish"
server.close
