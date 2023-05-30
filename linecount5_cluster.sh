#!/bin/bash

# Compile the C code
g++ linecount5.cpp -o linecount5

# Submit jobs to LSF queue
for file in *.cxsmiles; do
  outputfile="${file%.*}"
  bsub -J "linecount5" -q standard -R "rusage[mem=2GB]" -o "$outputfile"_count.out -e "$outputfile"_count.err \
    "./linecount5 \"$file\" \"$outputfile\"_count.txt"
done
