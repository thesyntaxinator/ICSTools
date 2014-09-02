my $num_args = $#ARGV + 1;
 if ($num_args != 2) { 
 	print "\nUsage: RemoveAlertsInICS.pl input.ics output.ics\nRemoves all alerts from the given .ics file.\n\n";
 	exit;
 }
 
my $inh = $ARGV[0];
open my $in, "<", $inh or die "Could not open $inh: $!";

my $outfileh = $ARGV[1];
open my $outfile, ">", $outfileh or die "Could not open $outfileh: $!";



my $suppress_print = 0; #false
while(my $line = <$in>)
{
	if(index($line, 'BEGIN:VALARM') != -1)
	{
		$suppress_print = 1; #true
	}
	
	if(!$suppress_print)
	{
		print $outfile $line;
	}
	
	if(index($line, 'END:VALARM') != -1)
	{
		$suppress_print = 0; #false
		# NOTE: printing also suppressed for this line (which we want)
	}
}