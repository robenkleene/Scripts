#!/usr/bin/env ruby

require 'open-uri'

if ARGV.empty?
  puts "No file specified"
  exit
end

file = ARGF.file

# Filename
filename = File.basename(file)

# File URL
file_path = File.expand_path(file)
file_url = URI.escape("file://" + file_path)

# Markdown Link
md_link = "[#{filename}](#{file_url})"

puts md_link