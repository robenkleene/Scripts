#!/usr/bin/env ruby

ARGF.each do |line|
  if line =~ /^\s*\*\s\[\s\]/
    line.sub!(/\[\s\]/, '[x]')
  elsif line =~ /^\s*\*\s\[x\]/
    line.sub!(/\[x\]/, '[ ]')
  end
  puts line
end