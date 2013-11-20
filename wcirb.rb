#!/usr/bin/env ruby

require 'webconsole'

PLUGIN_NAME = "IRB"

directory = ARGV[0]

text = STDIN.read
text.chomp!
text = text + "\n"

if !directory 
  directory = Dir.pwd
end

if !WebConsole::plugin_has_windows(PLUGIN_NAME)
  WebConsole::run_plugin(PLUGIN_NAME, directory)
end

WebConsole::plugin_read_from_standard_input(PLUGIN_NAME, text)