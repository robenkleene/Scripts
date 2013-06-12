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

var fs = require("fs");

if (argv.eh) {
	html = decodeURI(argv.eh);
} else if (argv.h) {
	html = fs.readFileSync(argv.h).toString();
}

if (argv.ej) {
	javaScript = decodeURI(argv.ej);
} else if (argv.j) {
	javaScript = fs.readFileSync(argv.j).toString();
}

if (html === undefined) {
	optimist.showHelp(fn=console.error)
	process.exit(1);
}

var jsdom = require("jsdom");
var doc = jsdom.jsdom(html);
if (!argv.o) {
	if (javaScript === undefined) {
		optimist.showHelp(fn=console.error)
		process.exit(1);
	}
	var win = doc.createWindow();
	var $ = require('jquery').create(win);
	eval(javaScript)
}

console.log(doc.documentElement.outerHTML);