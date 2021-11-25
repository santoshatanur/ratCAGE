#! /usr/bin/perl

$numarg = @ARGV;
if($numarg != 3)
 {
   print "Please provide three parameters\n\n";

   print "Usage: perl filterNormTC.pl <input file> <min TPM> <number of samples>\n";
   exit();
 }

open(FILE,$ARGV[0]) || die "unable to open file";
$tpm = $ARGV[1];
$num = $ARGV[2];

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
      for($i=4;$i<=$#a;$i++)
       {
        if($a[$i]>=$tpm)
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


