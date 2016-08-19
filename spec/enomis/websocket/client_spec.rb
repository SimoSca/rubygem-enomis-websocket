require 'spec_helper'
require 'websocket-eventmachine-client'


describe Enomis::Websocket::Client do

    before do
        puts "Starting:"
    end

    # see also let!() in RSpec
    # let!(:wsc){ Enomis::Websocket::Client.connect url }

    it "Make connection and manage as Object" do
        EM.run do
            def mytest(exp)
                expect(exp).to be(true)
                EventMachine::stop_event_loop
            end
            # Timeout::timeout(5) { mytest(false); }
            begin
                ws = Enomis::Websocket::Client.connect
                ws.onopen  { mytest(true) ; }
                ws.onerror { puts "onerror" ; mytest(false);  }
            rescue
                mytest(false)
            end
        end
    end # Connection test



    it "Make connection and manage inside Block Callback" do
        EM.run do
            def mytest(exp)
                expect(exp).to be(true)
                EventMachine::stop_event_loop
            end
            # Timeout::timeout(5) { mytest(false); }
            begin
                Enomis::Websocket::Client.connect do |ws|
                    ws.onopen  { mytest(true) ; }
                    ws.onerror { puts "onerror" ; mytest(false);  }
                end
            rescue
                mytest(false)
            end
        end
    end # Connection test


end
