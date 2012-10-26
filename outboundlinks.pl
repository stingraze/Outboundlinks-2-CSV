use strict;
use Data::Dumper;
use WWW::Mechanize;

my $mech = new WWW::Mechanize;
my $count = 0;
my $dbfile = "seeds.txt";
my $url;

open (I, "$dbfile") or die "Unable to open: $dbfile";
my @lines = <I>;
close I;

print "started";

foreach (@lines){
	chomp;

	$url = $_;
	$mech->get($url);

	my $hostname = quotemeta( $mech->uri()->host );

	my @outbound_links = $mech->find_all_links(
     url_abs_regex => qr<^(?!https?://\Q$hostname\E/)>,
);

	foreach ${_} (@outbound_links){
	
	
		open(OUT,">> alllinks.txt");
		print OUT ${_}->url_abs;
		print OUT "\n";
		close(OUT); 
		print $url;
		print "\n";
		print $count;
		print "\n";
		$count++;
	}
	
	open(OUT,">> outboundlinks.txt");
	print OUT "\"$url\",\"$count\"\n";
	close(OUT);
	$count = 0;

}

print "finished";
