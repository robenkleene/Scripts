#!/usr/bin/env ruby

require 'webconsole'

PLUGIN_NAME = "Node"

directory = ARGV[0]

text = STDIN.read
text.gsub!("\n", "\uFF00") # \uFF00 is the unicode character Coffee uses for new lines, it's used here just to consolidate code into one line
text = text + "\n"

if !directory 
  directory = Dir.pwd
end

if !WebConsole::plugin_has_windows(PLUGIN_NAME)
  WebConsole::run_plugin(PLUGIN_NAME, directory)
end

WebConsole::plugin_read_from_standard_input(PLUGIN_NAME, text)