// Example of socket to autoreload on server ping

;(function(){

    var toSend = (function(){
        obj = {
            msg: 'another message...',
            channel: 'reload',
            action: 'live-reload'
        }
        return function(o){
                if( typeof o === 'string') o = {msg: o}
                return JSON.stringify(Object.assign(obj, o));
        }
    })();

    var exampleSocket = new WebSocket("ws://localhost:4567");

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
