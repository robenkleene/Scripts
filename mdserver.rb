#!/usr/bin/env ruby

require "optparse"
require "webrick"
require "redcarpet"

include WEBrick

# Parse Arguements
logging = false
options = {}
option_parser = OptionParser.new do |opts|
  opts.on("-l") do
    logging=true
  end
end
option_parser.parse!

class MarkdownHandler < WEBrick::HTTPServlet::AbstractServlet

  def initialize(server, name)
    super
    @filepath = name
  end

  def do_GET(req, res)
    begin
      res.body = parse_markdown_file(@filepath)
      res['content-type'] = 'text/html'
    end
  end

  private
    def parse_markdown_file(filepath)

      	data = open(filepath){|io| io.read }

        redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
	body = redcarpet.render(data)

	filename = File.basename(filepath,File.extname(filepath))

	content = %(
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>#{filename}</title>
	</head>
	<body>#{body}</body>
	)
	
	return content
    end
end

WEBrick::HTTPServlet::FileHandler.add_handler("md", MarkdownHandler)

options = {:DocumentRoot => "~", :Port => 2000}
if !logging
  options.merge!(:Logger => WEBrick::Log.new("/dev/null"), :AccessLog => [nil, nil])
end

s = HTTPServer.new(options)

trap("INT") { s.shutdown }
s.start