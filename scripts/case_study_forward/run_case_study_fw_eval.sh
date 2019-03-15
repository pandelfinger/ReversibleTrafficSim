#!/bin/bash

echo reverse exploration
time ( ./main 3 1 -1 `expr 65536 \* 40` 32768 32768 0.1 2 2 10 2>&1 | tee out_bw | tail -n2)

echo forward exploration
time ( ./main 4 1 -1 `expr 65536 \* 40` 32768 32768 0.1 2 2 10 2>&1 | tee out_fw | tail -n2)

./scripts/case_study_forward/compare_fw_bw.pl out_fw out_bw
