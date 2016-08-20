# Enomis::Websocket

This extension is used for a simple personal purpose:

speedly create both `Websocket` `Client` and `Server` in `Ruby` (plus a javascript preformat example).

Direct usage is in my develop work, to emprove a simple way to refresh browser when change in local files happens:

1. start WSServer via this plugin
2. watch for file changes
3. make a javascript WSClient to dialog with WSServer
4. when change happens the WSServer must command the WSClient to refresh browser
5. WSClient receive command to refresh... then refresh!

Between step `4-5` there's a little specification: since WSServer is created in separate process how can I force it to send the refresh message? There's at least two options:

- create machine system events: when watch , I can propagate a notification that reach the Server, and so it send the refresh command
- without disturb the machine, when watch , I can create a WSClient (via Ruby) that send a message to Server: than it send refresh command and WSClient disconnect.

Actually I use the second:

watch witch `guard`, and realize the `creation/ping` of Ruby WSClient in `rake taks`, and trigger this task via `guard-rake`.

In the future I'll add a concrete example in [example](example) folder.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enomis-websocket'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enomis-websocket

## Usage


## Dependencies

To recycle most of the work I've used [websocket-eventmachine-server](https://github.com/imanel/websocket-eventmachine-server) and [websocket-eventmachine-client](https://github.com/imanel/websocket-eventmachine-client).

To better understand the work, I strongly recommend a read on [eventmachine](https://github.com/eventmachine/eventmachine) and `Reactor Pattern`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simosca/enomis-websocket.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
