#!/usr/bin/perl -w
use warnings;
use strict;
use File::Find;
use File::Basename;
use Data::Validate qw(:math);
use Text::Table;

my @directories = (".", "/root/directory1");
my @foundfiles;


# Here, we collect all .port files below each directory in @directories and put them
# into @foundfiles

find( sub { push @foundfiles, $File::Find::name if(-f $File::Find::name and /^\.*/ and /\.port$/) }, @directories );

# Redirect foundfiles output into a text file
open STDOUT , '>', "index.out";

# and output them all
print join ("\n",@foundfiles,"\n") ; 

# Now read the index.out file and count number of instances of each different port
my %count;
my $file = ("index.out");
open my $fh, '<', $file or die "Could not open '$file' $!";

while (my $line = <$fh>) {
      
      $line = basename($line);

      #Now remove the .port extention from each line which will give the filename only
      my ($filename, $path, $suffix) = fileparse($line, '\.[^\.]*'); 
      
      # Now validate that filenames are Hexdecimal, otherwise dont count and print in the table 
      if ($filename !~ m/[^0-9a-f]/i) {

           foreach my $str (split /\s+/, $filename) {

                 $count{$str}++;
           }
       }
 }

# make a table to organise the data
my $tbl = Text::Table->new("PORT", "FREQ");

foreach my $str (sort keys %count) {
        # output can be redirected to text file
        # printf "%-31s %s\n", $str, $count{$str};
        
        # print the output to the console
        # print STDERR $str ,'    ', $count{$str}, "\n";
     
        # load data into the table
        $tbl->load([$str, $count{$str}]);       
    
}
     # print the table
     print STDERR $tbl;





# JobTest
