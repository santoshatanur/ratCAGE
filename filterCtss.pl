#! /usr/bin/perl

$numarg = @ARGV;
if($numarg != 3)
 {
   print "Please provide three parameters\n\n";
   
   print "Usage: perl filterCtss.pl <input file> <min tag count> <number of samples>\n";
   exit();
 }

$tc = $ARGV[1];
$num = $ARGV[2];

open(FILE,$ARGV[0]) || die "unable to open file";

while(<FILE>)
 {
   $line=$_;
   chomp $line;
   if($line=~/^Chr/)
     {
       print "$line\n";
     }
   else
    {
      @a=split('\t',$line);
  

      for($i=3;$i<=$#a;$i++)
       {
        if($a[$i]>=$tc)
         {
          $tf++;
         }
       }
      if($tf>=$num)
       {
         print "$line\n";
       }
   $tf=0;
     }
 }
close(FILE);


