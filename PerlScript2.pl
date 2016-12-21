#!/usr/bin/perl

    use strict;
    use warnings;

    my $dir = '/root/directory1';

    opendir(DIR, $dir) or die $!;
    
    my $counter = 0;

    while (my $file = readdir(DIR)) {

        # We only want files
        next unless (-f "$dir/$file");

        # Use a regular expression to find files ending in .port
        next unless ($file =~ m/\.port$/);

        print "$file\t:";
        $counter++;
        print "$counter\n";

    }
     
    closedir(DIR);
    exit 0;
