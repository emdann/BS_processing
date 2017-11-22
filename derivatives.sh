#!/bin/bash


base_tab=$1

cat $base_tab | cut -f 2 | tail n+3 | awk '
    NR == 1{old = $1; next}     # if 1st line 
    {print $1 - old; old = $1}  # else...' > G.txt

cat $base_tab | cut -f 3 | tail n+3 | awk '
    NR == 1{old = $1; next}     # if 1st line 
    {print $1 - old; old = $1}  # else...' > A.txt

cat $base_tab | cut -f 4 | tail n+3 | awk '
    NR == 1{old = $1; next}     # if 1st line 
    {print $1 - old; old = $1}  # else...' > T.txt

cat $base_tab | cut -f 5 | tail n+3 | awk '
    NR == 1{old = $1; next}     # if 1st line 
    {print $1 - old; old = $1}  # else...' > C.txt

paste -d '\t' G.txt A.txt T.txt C.txt

