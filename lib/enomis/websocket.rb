# script files
require "enomis/websocket/version"
require "enomis/websocket/client"
require "enomis/websocket/server"

# command line files
require "enomis/websocket/command/serve"

module Enomis
    module Websocket
        # Your code goes here...
        DEFAULTS = {
            :host => 'localhost',
            :port => 4567
        }
    end
end
