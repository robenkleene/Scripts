#!/usr/bin/env perl

my $file = `ninbox`;
open FILE, ">$file";
select FILE;
while (<>) {
	print $_;
}
select STDOUT;
my $newfile = `renamefromtitle $file`;
print $newfile;