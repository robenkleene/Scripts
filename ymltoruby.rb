#!/usr/bin/env ruby

require 'YAML'

yml = YAML.load(ARGF.read)
puts yml.inspect