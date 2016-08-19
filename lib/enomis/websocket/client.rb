#####
# see
# => https://github.com/imanel/websocket-eventmachine-client
#####

require 'websocket-eventmachine-client'

module Enomis
    module Websocket
        # nested Clients are useful to use the class in two manner:
        # as object: ws = Enomis::Websocket::Client.connect url
        # as block yeld: Enomis::Websocket::Client.connect url  do |ws| ... end
        # see the self.connect above to understand
        module Client
            # opt = Enomis::Websocket::DEFAULTS.merge(opt)
            # host = opt[:host]
            # port = opt[:port]
            # Enomis::Websocket::Client.connect
            def self.connect(url = nil, options = {} )
                puts "works"
                opt = Enomis::Websocket::DEFAULTS.merge(options)
                # puts opt
                opt[:url] = url || "ws://#{opt[:host]}:#{opt[:port]}"
                # puts url
                client = Enomis::Websocket::Client::Current.connect(opt)
                # if there;s a block expression, then executes:
                # yield is as a callback, and client is the passed parameter
                yield client if block_given?

                return client
            end

            class Current

                def self.connect(opt)
                    ws = WebSocket::EventMachine::Client.connect(:uri => opt[:url])
                    return ws
                end
            end

        end
    end
end
