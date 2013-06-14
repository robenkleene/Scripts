#!/usr/bin/env node

var optimist = require('optimist')
    .usage('Usage: $0 -h [HTML file] -j [JavaScript file]')
    .boolean('o', 'e')
	.describe('h', 'HTML file')
	.describe('j', 'JavaScript file')
	.describe('eh', 'encoded HTML')
	.describe('ej', 'encoded JavaScript')
	.describe('e', 'Evaluate only, don\'t print the DOM')
	.describe('o', 'Output DOM without running JavaScript (useful for diffs)')
	.describe('url', 'Root URL')
	.alias('u', 'url')
;
var fs = require("fs");

var argv = optimist.argv;
var javaScript;
var html;
var rootURL;

function URLFromPath(path) {
	return "file://" + encodeURI(path) + "/";
}

function usage(errorMessage) {
	console.log(errorMessage);
	optimist.showHelp(fn=console.error);
	process.exit(1);
}

if (argv.url) {
	rootURL = URLFromPath(argv.url);
}

if (argv.eh) {
	html = decodeURI(argv.eh);
	if (!rootURL) {
		rootURL = URLFromPath(process.cwd());		
	}
} else if (argv.h) {
	html = fs.readFileSync(argv.h).toString();
	if (!rootURL) {
		var path = require('path');
		var directoryPath = path.resolve(path.dirname(argv.h));
		rootURL = URLFromPath(directoryPath);
	}
}

if (!html) {
	usage("ERROR: html is undefined");
}

if (!argv.o) {
	if (argv.ej) {
		javaScript = decodeURI(argv.ej);
	} else if (argv.j) {
		javaScript = fs.readFileSync(argv.j).toString();
	}
	if (!javaScript) {
		usage("ERROR: JavaScript is undefined");
	}
}

var jsdom = require("jsdom");
jsdom.env({
	html: html,
	src: [""], // An empty JavaScript src forces external scripts to be processed before the callback fires.
	url: rootURL,
	features: {
		FetchExternalResources   : ['script'],
		ProcessExternalResources : ['script'],
		MutationEvents           : "2.0"
	},
	done: function (errors, window) {
		// If there's no src set, this runs before external scripts. It runs after if there is a source set.

		if (errors) {
			console.log(errors);
		}

		window.console.log = console.log;		
		window.eval(javaScript);

		if (!argv.e) {
			console.log(window.document.documentElement.outerHTML);
		}
	}
});