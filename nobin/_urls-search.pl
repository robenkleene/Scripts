#!/usr/bin/env perl

my $search = "http://www.google.com/search?q=";

while (<>) {
	$_ =~ s{http://}{}gi;
	$_ =~ s{/.*}{}gi; # strip everything after first slash
	chomp($_);
	$search .= "site:$_+OR+";
}
$search =~ s/\+OR\+$//; # Remove last +OR+

`open "$search"`;