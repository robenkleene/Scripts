#!/usr/bin/perl

use Getopt::Long;

my $break;
GetOptions('b|break' => \$break);

while(<>) {
	if( m{(\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))))}i ) {
		print "$1\n";
		if (defined $break) { last; }
	}
}

