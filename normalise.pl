#! /usr/bin/perl

open(FILE,$ARGV[0]) || die "unable to open file";

while(<FILE>)
 {
   $line=$_;
   chomp $line;
   if($line !~ /^Chr/)
   {
     @a=split('\t',$line);
   
     @count=@a[4..$#a];
     for($i=0;$i<=$#count;$i++)
      {
        $totalcount[$i] = $totalcount[$i] + $count[$i];
      }
   }
 }
close(FILE);

open(FILE,$ARGV[0]) || die "unable to open file";

while(<FILE>)
 {
   $line=$_;
   chomp $line;
   if($line =~ /^Chr/)
    {
     print "$line\n";
    }
   else
    {
     @a=split('\t',$line);
     @count=@a[4..$#a];
     print "$a[0]\t$a[1]\t$a[2]\t$a[3]";
     for($i=0;$i<=$#count;$i++)
      {
       $normcount[$i] = sprintf("%.2f", (($count[$i] / $totalcount[$i]) * 1000000));
       print "\t$normcount[$i]";
      }
     print "\n";
    }
 }
close(FILE);

