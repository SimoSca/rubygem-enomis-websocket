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

                    @clients = []

                    WebSocket::EventMachine::Server.start(:host => host, :port => port) do |ws|
                        ws.onopen do |handshake|
                            puts "Client connected with params:"
                            puts "#{handshake}"
                            @clients << ws
                        end

                        # broadcast
                        ws.onmessage do |msg, type|
                            puts "Received message: #{msg}"
                            resp = nil
                            begin
                                msg = JSON.parse msg
                                # puts msg['action'] # not symbols since from web
                                resp = msg.to_json
                            rescue
                                # puts "error"
                                resp = msg
                            end

                            @clients.each do |socket|
                                socket.send resp
                            end

                        end

                        ws.onclose do
                            puts "Client disconnected"
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
