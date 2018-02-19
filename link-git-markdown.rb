#!/usr/bin/env ruby

require 'open-uri'
require 'shellwords'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.on('-l', '--line-number LINENUMBER', "Line Number") do |l|
    options[:line_number] = l
  end
  opts.on('-u', '--url-only', "URL only") do |u|
    options[:url_only] = u
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

# All the `git` commands need to run from the directory of the file argument

# Filename
line_number = options[:line_number].to_i
filename = File.basename(file)
directory = File.dirname(file)

commit = `cd #{Shellwords.escape(directory)} && git rev-parse HEAD`.strip
if !commit || $?.exitstatus != 0
  puts "Failed to get commit"
  exit 1
end

file_path = `cd #{Shellwords.escape(directory)} && git ls-tree --full-name --name-only HEAD #{Shellwords.escape(filename)}`.strip
if !file_path || $?.exitstatus != 0
  puts "Failed to get file path"
  exit 1
end

repo_path = `cd #{Shellwords.escape(directory)} && git config --get remote.origin.url | cut -f2 -d: | cut -f1 -d.`.strip
if !repo_path || $?.exitstatus != 0
  puts "Failed to get repository path"
  exit 1
end

github_subpath = URI.escape("#{repo_path}/blob/#{commit}/#{file_path}")
github_url = "https://github.com/#{github_subpath}"

if line_number > 0
  github_url << "#L#{line_number}"
end

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

if line_number > 0 && line_count > 1
  # `- 1` because the first line is already selected
  github_url << "-L#{line_number + line_count - 1}"
end

if options[:url_only]
  puts github_url
  exit 0
end

# Markdown Link
md_link = "[`#{file_path}`](#{github_url})"
print md_link
print quoted unless quoted == ""
