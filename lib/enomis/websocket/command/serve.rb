module Enomis
    module Websocket
        module Command
            class Serve
                def initialize(args, options)
                    Enomis::Websocket::Server.start
                end
            end
        end
    end
end
