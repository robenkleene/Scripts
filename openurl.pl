#!/usr/bin/perl

while(<>) {
	if( m{(\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))))}i ) {
		`open "$1"`;
		last;
	}
}

