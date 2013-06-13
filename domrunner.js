#!/usr/bin/env node

var optimist = require('optimist')
    .usage('Usage: $0 -h [HTML file] -j [JavaScript file]')
    .boolean('o')
	.describe('h', 'HTML file')
	.describe('j', 'JavaScript file')
	.describe('eh', 'encoded HTML')
	.describe('ej', 'encoded JavaScript')
	.describe('o', 'Output DOM without running JavaScript (useful for diffs)')
;

var argv = optimist.argv;
var javaScript;
var html;
var rootURL;

var fs = require("fs");

function URLFromPath(path) {
	return "file://" + encodeURI(path) + "/";
}

if (argv.eh) {
	html = decodeURI(argv.eh);
	rootURL = URLFromPath(process.cwd());
} else if (argv.h) {
	html = fs.readFileSync(argv.h).toString();
	var path = require('path');
	var directoryPath = path.resolve(path.dirname(argv.h));
	rootURL = URLFromPath(directoryPath);
}

if (html === undefined) {
	optimist.showHelp(fn=console.error)
	process.exit(1);
}

if (!argv.o) {
	if (argv.ej) {
		javaScript = decodeURI(argv.ej);
	} else if (argv.j) {
		javaScript = fs.readFileSync(argv.j).toString();
	}
	if (javaScript === undefined) {
		optimist.showHelp(fn=console.error)
		process.exit(1);
	}
}

var jsdom = require("jsdom");
jsdom.env({
	html: html,
	src: [javaScript],
	url: rootURL,
	features: {
		FetchExternalResources   : ['script'],
		ProcessExternalResources : ['script'],
		MutationEvents           : "2.0"
	},
	done: function (errors, window) {
		console.log(window.document.documentElement.outerHTML);
	}
});