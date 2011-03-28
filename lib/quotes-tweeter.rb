#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
Bundler.setup
require "twitter"
require "yajl"

require File.expand_path("quotes/database", File.dirname(__FILE__))
require File.expand_path("quotes/tweeter", File.dirname(__FILE__))

# Parse options.
options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: quotes_tweeter.rb [options]"
  opts.on("-c", "--config FILE", "Config file.") do |config|
    options[:config] = config
  end
end

# Run tweeter or exit.
if ARGV.length > 0
  optparse.parse!
  if config = options[:config]
    Quotes::Tweeter.new(config).tweet
  end
else
  puts optparse.help
end
