guard 'rspec', cmd: "bundle exec rspec" do
  # watch /lib/ files
  watch(%r{^lib/enomis/(.+).rb$}) do |m|
      puts "watch!!"
    "spec/enomis/#{m[1]}_spec.rb"
  end
  # watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
