require "socket"

server = TCPServer.open(8008)

while true
  Thread.start(server.accept) do |socket|
   # socket = server.accept
    request = socket.gets
    if request.include? "yahoo"
       socket.puts ['HTTP/1.1 301 redirect',
                     'Server: liblib',
                     'Content-Type: text/html; charset=utf-8',
                     'Location:https://www.yahoo.co.jp/']
    elsif request.include? "GET"
      body =
      '<html>
      <body>
      <h1>Life i Business</h1>
      <p style = "color:red">生きるをもっと</p>
      <p style = "color:blue">ポジティブに</p>
      </body>
      </html>'
      socket.puts ['HTTP/1.1 301 redirect',
                     'Server: liblib',
                     'Content-Type: text/html; charset=utf-8',
                     "Content-Length: #{body.length}\r\n\r\n"].join("\r\n")
      socket.puts body
    end
  p 'socket close'
  socket.close
  end
end
p "finish"
server.close