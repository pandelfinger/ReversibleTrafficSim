#!/usr/bin/perl -w

use strict;

my $final_state_marker = "final state";
my $starting_state_marker = "starting state";

open(IN_FW, $ARGV[0]);
open(IN_BW, $ARGV[1]);

my %fw_starting_states;
my %bw_starting_states;

while(my $line = <IN_FW>) {
  if($line =~ /^$starting_state_marker$/) {
    my $starting_state_line = <IN_FW>;
    my @states;

    while(defined $starting_state_line && $starting_state_line =~ /(\d+), (\d+), (\d+), (\d+)/) {
      if($2 == 0) {
        $starting_state_line = <IN_FW>;
        next;
      }
      
      push(@states, "$3,$4");

      $starting_state_line = <IN_FW>;
    }

    $fw_starting_states{$states[0] . '-' . $states[1]} = 1;
    $fw_starting_states{$states[1] . '-' . $states[0]} = 1;
  }

}

while(my $line = <IN_BW>) {
  if($line =~ /^$starting_state_marker$/) {
    my $starting_state_line = <IN_BW>;
    my @states;

    while(defined $starting_state_line && $starting_state_line =~ /(\d+), (\d+), (\d+), (\d+)/) {
      if($2 == 0) {
        $starting_state_line = <IN_BW>;
        next;
      }

      push(@states, "$3,$4");

      $starting_state_line = <IN_BW>;
    }

    $bw_starting_states{$states[0] . '-' . $states[1]} = 1;
    $bw_starting_states{$states[1] . '-' . $states[0]} = 1;
  }

}

my $mismatch = 0;
foreach my $key (keys %fw_starting_states) {
  if(!defined $bw_starting_states{$key}) {
    print "in fw, but not bw: $key\n";
    $mismatch = 1;
  }
}

foreach my $key (keys %bw_starting_states) {
  if(!defined $fw_starting_states{$key}) {
    print "in bw, but not fw: $key\n";
    $mismatch = 1;
  }
}

print scalar (keys %fw_starting_states) . " initial states from forward exploration, " . scalar (keys %bw_starting_states) . " initial states from backward exploration, any mismatch: $mismatch\n";
