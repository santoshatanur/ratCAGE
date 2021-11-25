#! /usr/bin/perl

open(FILE,$ARGV[0]) || die "unable to open file";

$pchr="";
$pstart=0;
$pend=0;

print "Chr\tPos\tStrand\tCount\n";

while(<FILE>)
 {
   $line=$_;
   chomp $line;
   @a=split("\t",$line);
      if($a[0] ne $pchr ||  $a[5] != $pstrand || ($pstrand eq "-" && $a[2] != $pend) || ($pstrand eq "+" && $a[1] != $pstart))
       {
         if($pstrand eq "-" )
         {
           print "$pchr\t$pend\t$pstrand\t$count_neg\n";
         }
         if($pstrand eq "+")
         {
           print "$pchr\t$pstart\t$pstrand\t$count_plus\n";
         }
         if($a[5] eq "-") { $count_neg=1; }
         if($a[5] eq "+") { $count_plus=1; }
       }
      if(($a[0] eq $pchr) && ($a[2] == $pend) && ($a[5] eq "-"))
       {
         $count_neg++;
       }
      if( ($a[0] eq $pchr) && ($a[1] == $pstart) && ($a[5] eq "+"))
       {
         $count_plus++;
       }
   $pchr=$a[0];
   $pstart=$a[1];
   $pend=$a[2];
   $pstrand=$a[5];
 }
 
#chr1    172852  172949  HWI-ST554:233:C5JMGACXX:3:2104:19975:74290/1    50      -
