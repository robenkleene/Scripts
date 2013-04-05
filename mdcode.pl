#!/usr/bin/env perl

my $mode;

sub find_mode_from_line {
	/(`|^\t)/;
	$mode = $1;
}

while (<>) {
	if (!defined $mode) { 
		&find_mode_from_line($_);
	}

	if ($mode =~ /^\t/) {
		if (/^\t(.*)$/) {
			print "$1\n";
		} else {
			# If it is not a blank line we are done
			if (/^\s*$/) { 
				print "$1\n";
			} else {
				last;
			}
		}		
	} elsif ($mode =~ /`/) {
		/`(.*)`/;
		print $1;
		last;
	}
}