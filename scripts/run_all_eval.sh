#!/bin/bash

echo executing epoch length experiment
./scripts/garbage_bits/run_epoch_length_eval.sh

echo executing garbage bits experiment
./scripts/garbage_bits/run_gb_eval.sh

echo executing executing time experiment
./scripts/executing_time/run_executing_time_eval.pl

echo executing input transition experiment
./scripts/velocity_ins/run_velocity_ins_eval.sh

echo executing reverse exploration experiment
./scripts/exploration/run_exploration_eval.sh

echo executing case study experiment
./scripts/case_study/run_case_study_eval.sh

ls *.eps
