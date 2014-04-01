#!/usr/bin/env ruby

ARGF.each do |line|
  if line =~ /^\s*\*\s\[.\]/
    line.sub!(/\*\s\[.\]/, '*')
  elsif line =~ /^\s*\*/
    line.sub!(/\*/, '* [ ]')
  end
  puts line
end