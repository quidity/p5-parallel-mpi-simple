my $incs;
$incs .= " -I$_" foreach @INC;
my @newout = sort {
    (($a =~ /(\d+)/g)[0] <=> ($b =~ /(\d+)/g)[0])
} `mpirun -np 2 $^X $incs ic.pl`;
print "1..24\n";
if (@newout < 24) {
    print "not ok 1 # mpirun failed.  Do you need to start mpd?\n";
}
print @newout;
