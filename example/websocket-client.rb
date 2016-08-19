require "enomis/websocket"

EM.run do
    ws = Enomis::Websocket::Client.connect
    ws.onopen  { ws.send('hi'); ws.send('hello');}
    ws.onerror { puts "onerror" ; }

    EM.add_timer(5) do
        puts "BOOM"
        EM.stop_event_loop
    end
    ws.onmessage do |msg, type|
        puts "received from server: #{msg}"
    end
end
