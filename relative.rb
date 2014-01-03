#!/usr/bin/env ruby

require 'pathname'
require 'optparse'
require 'shellwords'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: relative destination [-s source]"
  opts.on("-s source", "--source source", "Source") do |v|
    options[:source] = v
  end
  opts.on('-h', '--help', 'Help') do
    puts opts
    exit
  end
end
optparse.parse!

source = options[:source]
if !source
  source = Dir.pwd
end
  
destination = ARGV.pop
if !destination
  puts optparse
  raise optparse::MissingArgument
end

if !File.exist?(destination)
  puts "Destination doesn't exist"
  puts optparse
  raise OptionParser::InvalidArgument
end

if !File.exist?(source)
  puts "Source doesn't exist"
  puts optparse
  raise OptionParser::InvalidArgument
end

source = Shellwords.escape(source)
destination = Shellwords.escape(destination)

puts Pathname.new(destination).relative_path_from(Pathname.new(source)).to_s