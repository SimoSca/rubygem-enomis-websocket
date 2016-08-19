# def wait_for
#     timeout = 5
#     start = Time.now
#     x = yield
#     until x[:need]
#         if Time.now - start > timeout
#             # non alzo un errore, ma provo un tes
#             #raise "Wait to long here. Timeout #{timeout} sec"
#             # it "#{x[:text]}" do
#                 expect(x[:expect]).to eq(x[:equals])
#             # end
#         end
#         sleep(0.3)
#         x = yield
#     end
# end

# describe Enomis::Websocket::Client do
#     before do
#         puts "Starting:"
#     end


WebSocket::Client::Simple.connect 'ws://localhost:4567' do |ws|
  ws.on :open do
    puts "connect!"
  end

  ws.on :message do |msg|
    puts msg.data
  end
end

    # see also let!() in RSpec
    url = 'ws://localhost:4567'
    wsc = WebSocket::Client::Simple.connect url
    # let!(:wsc){ WebSocket::Client::Simple.connect url }

    # it "Make connection" do
        isopen = false
        # url = 'ws://localhost:4567'
        # wsc.connect url
        puts "try"
        wsc.on :open do
            puts "-- websocket open (#{ws.url})"
            wsc.send("test!!")
            # wsc.close
            isopen = true
        end
        wsc.send('hi zio!')
        loop do
            wsc.send STDIN.gets.strip
        end
