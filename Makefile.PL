use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# Make sure people aren't being stupid... it's been known to happen.

print <<ENDOFMESSAGE;
I'm about to build the Makefile for Parallel::MPI::Simple.

If you have mpicc installed, I will attempt to use the arguements
it suggests to compile and link the module.  You will also have to
have already started mpd for the tests to work.

If you find you cannot build this module, or that the tests fail, you
may be on an odd system where you need to do more than pass -lmpi to
your C compiler to build MPI applications.  If this is the case, rerun
perl Makefile.PL with appropriate LDFLAGS= and CCFLAGS= arguments.

Also, this module is very new so if you manage to get it working on one
of the systems not listed in INSTALL I'd love to hear about it.
ENDOFMESSAGE

my ($libs, $ccflags) = ("", "");
# try to get this information from mpicc, should quietly fail if not
{
    my @lines = `mpicc -help`;
    foreach my $line (@lines) {
	if ($line =~ /-link-info/) {
	    my $linkinfo = `mpicc -link-info`;
	    my @entries = split (/\s+/, $linkinfo);
	    $libs = join(" ", grep {/^-[Ll]/} @entries);
	}
	if ($line =~ /-compile-info/) {
	    my $compileinfo = `mpicc -compile-info`;
	    my @entries = split (/\s+/, $compileinfo);
	    $ccflags = join(" ", grep {/^-[ILl]/} @entries);
	}
    }
    if ($libs || $ccflags) {
	print STDERR "guessing values for\n LIBS:$libs\n CCFLAGS:$ccflags\n";
    }
    else {
	print STDERR "Could not determine options for mpicc, using defaults\n";
    }
}

# Check that people have tried to define linking and compiling options...
WriteMakefile(
    'NAME'	=> 'Parallel::MPI::Simple',
    'VERSION_FROM' => 'Simple.pm', # finds $VERSION
    'PREREQ_PM' => {Storable => 0},
    'LIBS' => $libs || "-lmpi",
    'CCFLAGS' => $ccflags || "",
);
