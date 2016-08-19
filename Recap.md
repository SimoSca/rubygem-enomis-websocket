Recap
=====

Simple summarize of steps improved to realize this gem skeleton, with some expanation.


#### Generate Main Files

`bundle gem enomis-websocket`


### Gemspec

modify `enomis-websocket.gemspec` ; if need run `bundle install`

#### Rspec

add project dependencies, such ad

````
# development
spec.add_development_dependency "rspec-nc" # provides native notifications on Mac OS X (not essential)
spec.add_development_dependency "guard"
spec.add_development_dependency "guard-rspec"

# gem dep
spec.add_dependency "websocket"
````



**Spec Files**

`spec/spec_helper.rb` is usually for depencies: I should add the `require <package>`


#### Guard

create `Guardfile` and add relevant code, such as

````
guard 'rspec', cmd: "bundle exec rspec" do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end
  # watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
````

so that I can run

````
bundle exec guard
````


Module
------

in Ruby each module can extend another as in `javascript prototype`, that is dinamically ad properties/methods in different files:

in `version.rb` I've

````
module Enomis
  module Websocket
    VERSION = "0.1.0"
  end
end
````

and in `example.rb` I've

````
module Enomis
  module Websocket
    PI = 3.14
  end
end
````

then requiring both in script , I can:

````
puts Enomis::Websocket::VERSION
puts Enomis::Websocket::PI
````

### Common Require

if gem consists of multiple script, such as `lib/enomis/websocket/client.rb`, to avoid manual require of each script, I can use `lib/enomis/websocket.rb` to collect all my dependencies, that is adding

````
require "websocket/client.rb"
````

and magic is done!!!



### Command Line

to add command line I've used [Commander](https://github.com/commander-rb/commander), that is:

1. added `spec.add_dependency "commander"` to `enomis-websocket.gemspec`

2. create `exe` directory in this gem root

3. `cd exe/` and run `commander init enomis-websocket`


To better manage my command, I've create a separate commander `directory` into `lib`, and clearly added `required` each file into `lib/enomis/websocket.rb`



### Build

Create a local gem build

`gem build enomis-websocket.gemspec`


### Publish on github

optional...


Testing
--------

* it's better test each time with `rspec`

* local CLI test with `bundle exec ruby exe/enomis-websocket`
