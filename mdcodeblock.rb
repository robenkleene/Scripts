#!/usr/bin/env ruby

if !ARGV.empty?
  filename = ARGV.shift
  print "`#{filename}`"
end

if !STDIN.tty?
  whitespace = nil
  ARGF.each do |line|
    if !whitespace
      puts ":\n\n"
      if line =~ /^(\s{4}|\t)/
        whitespace = ""
      else
        whitespace = "\t"
      end
    end
    puts whitespace + line
  end
end