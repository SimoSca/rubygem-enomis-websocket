var toSend = (function(){
        obj = {
            msg: 'another message...',
            channel: 'reload'
        }
        return function(o){
                if( typeof o === 'string') o = {msg: o}
                return JSON.stringify(Object.assign(obj, o));
        }
    })();
    var exampleSocket = new WebSocket("ws://localhost:4567");
    exampleSocket.onopen = function (event) {
      exampleSocket.send("Can you hear me?");
      $(document).on('click', function(){
          obj = {
              msg: 'lol',
              channel: 'reload',
              action: 'fullcontact'
          }

         exampleSocket.send(toSend(obj))
         exampleSocket.send(toSend('bella zio'))
      });
    };
    exampleSocket.onmessage = function (event) {
        var ctx;
        try{
            ctx = JSON.parse(event.data)
        }catch(err){
            console.log(err)
        }

        console.log(event)
        console.log(ctx.action)
        console.log(event.data.action)

    }
