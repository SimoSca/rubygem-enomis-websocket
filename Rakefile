require "bundler/gem_tasks"
require "rspec/core/rake_task"

require_relative "lib/enomis/websocket"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


task :serve do
    Enomis::Websocket::Server.start
end
