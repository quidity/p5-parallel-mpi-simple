my $incs;
$incs .= " -I$_" foreach @INC;
my @newout = sort {
    (($a =~ /(\d+)/g)[0] <=> ($b =~ /(\d+)/g)[0])
} `mpirun -np 2 $^X $incs ic.pl`;
print "1..".scalar(@newout)."\n";
print @newout;
