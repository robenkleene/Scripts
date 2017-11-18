#!/usr/bin/env ruby

require 'open-uri'
require 'shellwords'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.on('-l', '--line-number LINENUMBER', "Line Number") do |f|
    options[:line_number] = f
  end
end
optparse.parse!

if ARGV.empty?
  puts "No file specified"
  exit 1
end

file = ARGF.file

if ARGV.empty?
  postfix = ""
else
  postfix = ARGV[0]
end

# Filename
line_number = options[:line_number].to_i
filename = File.basename(file)
commit = `git rev-parse HEAD`.strip
file_path = `git ls-tree --full-name --name-only HEAD #{Shellwords.escape(filename)}`.strip
repo_path = `git config --get remote.origin.url | cut -f2 -d: | cut -f1 -d.`.strip
github_subpath = URI.escape("#{repo_path}/blob/#{commit}/#{file_path}")
github_url = "https://github.com/#{github_subpath}"

# Process the quoted portion
if !STDIN.tty?
  quoted = ""
  whitespace = nil
  line_count = 0
  while line = STDIN.gets
    if !whitespace
      quoted << ":\n\n"
      if line =~ /^(\s{4}|\t)/
        whitespace = ""
      else
        whitespace = "\t"
      end
    end
    quoted << "#{whitespace + line}"
    line_count += 1
  end
end

if line_number > 0
  github_url << "#L#{line_number}"
  if line_count > 0
    github_url << "-L#{line_number + line_count}"
  end
end

# Markdown Link
md_link = "[`#{file_path}`](#{github_url})"
print md_link
print quoted unless quoted == ""
