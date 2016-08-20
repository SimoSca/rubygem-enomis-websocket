module Enomis
    module Websocket
        module Command
            class Javascript
                def initialize(args, options)

                    opt = Enomis::Websocket::DEFAULTS

                    js = %Q{
                        // Example of socket to autoreload on server ping

                        ;(function(){

                            var toSend = (function(){
                                obj = {
                                    msg: '',
                                    channel: 'reload',
                                    action: 'browser-reload'
                                }
                                return function(o){
                                        if( typeof o === 'string') o = {msg: o}
                                        return JSON.stringify(Object.assign(obj, o));
                                }
                            })();

                            var exampleSocket = new WebSocket("ws://#{opt[:host]}:#{opt[:port]}");

                            exampleSocket.onopen = function (event) {
                                exampleSocket.send(toSend('hi'));
                            };

                            exampleSocket.onmessage = function (event) {
                                var ctx;
                                try{
                                    ctx = JSON.parse(event.data)
                                    if(ctx.action == "live-reload") window.location.reload()
                                }catch(err){
                                    console.log(err)
                                }
                            }

                        })();

                    }

                    puts js

                end
            end
        end
    end
end
