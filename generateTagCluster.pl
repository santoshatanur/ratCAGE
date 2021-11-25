#! /usr/bin/perl

open(FILE,$ARGV[0]) || die "unable to open file";
$i=0;
$ppos=0;
$pflag=0;
$pcount=0;
$counter=0;
while(<FILE>)
  {
    $line=$_;
    if($line=~/^Chr\s+Pos\s+Strand\s+(.*)/)
     {
       print "Chr\tStart\tEnd\tStrand\t$1\n";
     }
    else
     {
    @a=split(/\t/,$line);
    $chr=$a[0];
    $pos=$a[1];
    $flag=$a[2];
    $posdiff = $pos-$ppos;
    
    if($chr ne $pchr || $flag ne $pflag || $posdiff > 20)
      {
       for($j=0;$j<=$#clust;$j++)
        {
          @b=split(/\t/,$clust[$j]);
          if($pflag eq "+")
           {
           if($j==0) {$clustchr=$b[0]; $cluststart=$b[1]; $cluststrand=$b[2]}
           }
          if($pflag eq "-")
           {
           if($j==0) {$clustchr=$b[0]; $cluststart=$b[1]-1; $cluststrand=$b[2]}
           }
         if($j==$#clust) 
           {
             if($pflag eq "+")
               {
                 $clustend=$b[1] + 1;
               }
             if($pflag eq "-")
               {
                $clustend=$b[1];
               }
           }

          for($k=3;$k<=$#b;$k++)
            {
              $clustcount[$k] = $clustcount[$k] + $b[$k];
              $tc = $tc + $b[$k];
            }
        }
       if($counter >0)
        {
         print "$clustchr\t$cluststart\t$clustend\t$cluststrand";
         for($k=3;$k<=$#b;$k++) {print "\t$clustcount[$k]";}
         print "\n";
        }
       $counter++;
       $i=0;
       @clust=();
       @clustcount=();
       $tc=0; 
       $clust[$i]=$line;
      }
       
    if($chr eq $pchr && $flag eq $pflag && $posdiff <= 20) 
      {
       $i++;
       $clust[$i]=$line;
      }
       $pchr=$chr;
       $ppos=$pos;
       $pflag=$flag;
   }
 }

      for($j=0;$j<=$#clust;$j++)
        {
          @b=split(/\t/,$clust[$j]);
          if($pflag eq "+")
           {
           if($j==0) {$clustchr=$b[0]; $cluststart=$b[1]; $cluststrand=$b[2]}
           }
          if($pflag eq "-")
           {
           if($j==0) {$clustchr=$b[0]; $cluststart=$b[1]-1; $cluststrand=$b[2]}
           }
          if($j==$#clust) 
           {
             if($pflag eq "+")
               {
                 $clustend=$b[1] + 1;
               }
             if($pflag eq "-")
               {
                $clustend=$b[1];
               }
           }
          for($k=3;$k<=$#b;$k++)
            {
              $clustcount[$k] = $clustcount[$k] + $b[$k];
              $tc = $tc + $b[$k];
            }

        }
       print "$clustchr\t$cluststart\t$clustend\t$cluststrand";
       for($k=3;$k<=$#b;$k++) {print "\t$clustcount[$k]";}
       print "\n";

