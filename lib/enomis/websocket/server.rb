#####
# see
# => https://github.com/imanel/websocket-eventmachine-server
#####

require "websocket-eventmachine-server"
require "json"

module Enomis
    module Websocket
        module Server

            def self.start(opt = {} )
                opt = Enomis::Websocket::DEFAULTS.merge(opt)
                host = opt[:host]
                port = opt[:port]
                # by default is in broadcast mode;
                # could be great improve channels and other
                EM.run do
                    puts "start server on ws://#{host}:#{port}"
                    @count = 0;
                    @clients = []
                    # here "ws" is a forked ws,
                    # that is think `ws` as Client-Server socket, for each client
                    # not as one ws associated to the server:
                    #
                    # "start" methos is listen to a connection request, and when happens
                    # the event machine create a webscocket "ws" , and pass this do the block,
                    WebSocket::EventMachine::Server.start(:host => host, :port => port) do |ws|

                        i = @count
                        @count = @count + 1

                        ws.onopen do |handshake|
                            puts "Client connected with params:"
                            puts "#{handshake}"
                            # puts "#{i}"
                            @clients << Hash["id" => i, "ws" => ws]
                        end

                        # broadcast
                        ws.onmessage do |msg, type|
                            # puts "Received message: #{msg}"
                            resp = nil
                            begin
                                msg = JSON.parse msg
                                # puts msg['action'] # not symbols since from web
                                resp = msg.to_json
                            rescue
                                # puts "error"
                                resp = msg
                            end

                            # puts "message received"
                            # puts "#{i}"
                            # ws.send "received!"

                            @clients.each do |socket|
                                # puts "#{i}"
                                # puts "send to ..."
                                socket['ws'].send resp
                            end

                        end

                        ws.onclose do
                            # remove clients no more existing
                            @clients.delete_if { | socket |  socket['id'] == i  }
                            puts "Client disconnected: #{i} and total #{@count}, but existng #{@clients.length}"
                        end

                        ws.onerror do |error|
                            puts "Error occured: #{error}"
                        end

                    end
                end


            end #start

        end
    end
end
