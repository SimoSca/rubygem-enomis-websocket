###
# Inspired by
# => https://github.com/shokai/websocket-client-simple
###

# to appen "on" events/emitter to class
require 'event_emitter'
require 'websocket'
require 'socket'
require 'openssl'
require 'uri'

module Enomis
    module Websocket
    # nested Clients are useful to use the class in two manner:
    # as object: ws = Enomis::Websocket::Client.connect url
    # as block yeld: Enomis::Websocket::Client.connect url  do |ws| ... end
    # see the self.connect above to understand
    module Client


        # Enomis::Websocket::connect
        def self.connect(url, options={})
            puts "preyeld ***************"
            client = ::Enomis::Websocket::Client::Client.new
            # if there;s a block expression, then executes:
            # yield is as a callback, and client is the passed parameter
            yield client if block_given?
            puts "yeld ***************"
            client.connect url, options
            return client
        end

        class Client

            # include makes the EventEmitter methods available to an instance of a class (i.e. once() )
            # while extend makes the foo method available to the class itself.
            include EventEmitter
            attr_reader :url, :handshake

            # hankshake + listening Thread into while message loop
            def connect(url, options={})
                puts "start ***************"
                return if @socket
                @url = url
                uri = URI.parse url
                @socket = TCPSocket.new(uri.host,
                                  uri.port || (uri.scheme == 'wss' ? 443 : 80))
                if ['https', 'wss'].include? uri.scheme
                    ctx = OpenSSL::SSL::SSLContext.new
                    ctx.ssl_version = options[:ssl_version] || 'SSLv23'
                    ctx.verify_mode = options[:verify_mode] || OpenSSL::SSL::VERIFY_NONE #use VERIFY_PEER for verification
                    cert_store = OpenSSL::X509::Store.new
                    cert_store.set_default_paths
                    ctx.cert_store = cert_store
                    @socket = ::OpenSSL::SSL::SSLSocket.new(@socket, ctx)
                    @socket.connect
                end
                puts url
                @handshake = ::WebSocket::Handshake::Client.new :url => url, :headers => options[:headers]
                puts @handshake.to_s
                @handshaked = false
                @pipe_broken = false
                frame = ::WebSocket::Frame::Incoming::Client.new
                @closed = false
                once :__close do |err|
                    puts "clooooseeee ***********"
                    close
                    emit :close, err
                end
                puts frame
                @thread = Thread.new do
                    puts "start while!!!!***********"
                    while !@closed do
                        begin
                            # puts "1 ***************"
                            unless recv_data = @socket.getc
                                puts "2 ***************"
                                sleep 1
                                next
                            end
                            unless @handshaked
                                # puts "3 ***************"
                                @handshake << recv_data
                                if @handshake.finished?
                                    @handshaked = true
                                    puts "Open!!!"
                                    emit :open
                                end
                            else
                                puts "4 ***************"
                                frame << recv_data
                                while msg = frame.next
                                    puts "msg ***************"
                                    emit :message, msg
                                end
                            end
                        rescue => e
                            puts "error ***************"
                            emit :error, e
                        end
                    end
                end
                puts "write ***************"
                @socket.write @handshake.to_s
            end

            # send function with emitter
            def send(data, opt={:type => :text})
                puts "send ***************"
                return if !@handshaked or @closed
                puts "after send************"
                type = opt[:type]
                frame = ::WebSocket::Frame::Outgoing::Client.new(:data => data, :type => type, :version => @handshake.version)
                begin
                    @socket.write frame.to_s
                rescue Errno::EPIPE => e
                    @pipe_broken = true
                    emit :__close, e
                end
            end


            # on close event
            def close
                puts "close ***************"
                return if @closed
                if !@pipe_broken
                    send nil, :type => :close
                end
                @closed = true
                @socket.close if @socket
                @socket = nil
                emit :__close
                Thread.kill @thread if @thread
            end

            # on established connection
            def open?
                puts "open? ***************"
                @handshake.finished? and !@closed
            end


            def test
                return "test"
            end

        end # class Client

    end
    end
end
