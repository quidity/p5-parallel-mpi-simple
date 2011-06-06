use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# Make sure people aren't being stupid... it's been known to happen.

print <<ENDOFMESSAGE;
I'm about to build the Makefile for Parallel::MPI::Simple.

If you find you cannot build this module, or that the tests fail, you
may be on an odd system where you need to do more than pass -lmpi to
your C compiler to build MPI applications.  If this is the case, rerun
perl Makefile.PL with appropriate LDFLAGS= and CCFLAGS= arguments.

Also, this module is very new so if you manage to get it working on one
of the systems not listed in INSTALL I'd love to hear about it.
ENDOFMESSAGE

# Check that people have tried to define linking and compiling options...
WriteMakefile(
    'NAME'	=> 'Parallel::MPI::Simple',
    'VERSION_FROM' => 'Simple.pm', # finds $VERSION
    'PREREQ_PM' => {Storable => 0},
    'LIBS' => "-lmpi",
);
