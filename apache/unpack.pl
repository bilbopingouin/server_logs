#!/usr/bin/perl

use strict;
use warnings;

print "year,mon,day,hour,min,ip,reqt,reqp,status,size,ref"

while(<STDIN>)
{
  my $line = $_;

  if ( $line =~ /^(\d+\.\d+\.\d+\.\d+)\ \-\ \-\ \[(\d+)\/(\w+)\/(\d+):(\d+):(\d+):(\d+)\ [+-]\d+\]\ *"(GET|CONNECT)\ *\/\ *([^"]+)"\ +(\d+)\ +(\d+)\ +"([^"]+)"\ +"([^"]+)"/ )

  {
    my $ip = $1;
    my $day = $2;
    my $month_alpha = $3;
    my $year = $4;
    my $hour = $5;
    my $min = $6;
    my $con_key = $8;
    my $con_pro = $9;
    my $status = $10;
    my $size = $11;
    my $ref = $12;
    my $useragent = $13;

    my $month = $month_alpha;

    if ( $month_alpha =~ /Jan/ )
    {
      $month = "01";
    }
    if ( $month_alpha =~ /Feb/ )
    {
      $month = "02";
    }
    if ( $month_alpha =~ /Mar/ )
    {
      $month = "03";
    }
    if ( $month_alpha =~ /Apr/ )
    {
      $month = "04";
    }
    if ( $month_alpha =~ /May/ )
    {
      $month = "05";
    }
    if ( $month_alpha =~ /Jun/ )
    {
      $month = "06";
    }
    if ( $month_alpha =~ /Jul/ )
    {
      $month = "07";
    }
    if ( $month_alpha =~ /Aug/ )
    {
      $month = "08";
    }
    if ( $month_alpha =~ /Sep/ )
    {
      $month = "09";
    }
    if ( $month_alpha =~ /Oct/ )
    {
      $month = "10";
    }
    if ( $month_alpha =~ /Nov/ )
    {
      $month = "11";
    }
    if ( $month_alpha =~ /Dec/ )
    {
      $month = "12";
    }
    

    print $year,',',$month,',',$day,',',$hour,',',$min,',',$ip,',';
    print $con_key,',',$con_pro,',',$status,',',$size,',';
    print $ref,"\n";
    #print $ref,',',$useragent,"\n"; # useragent not necessarily useful and complicate the output

  }

  #print $line;
}
