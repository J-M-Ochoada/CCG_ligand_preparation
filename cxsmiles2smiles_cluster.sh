#!/bin/bash 

module load chemaxon/marvin-22.11

# Create smiles directory (if it does not exist)
mkdir -p "$(pwd)/smiles"

# Script to launch a job on bsub queue for each cxsmiles file and convert to smiles
for cxsmiles_file in "$(pwd)"/*cxsmiles; do
  outputfile="$(pwd)/smiles/$(basename ${cxsmiles_file%.*})"
  echo "Input file: $cxsmiles_file"
  echo "Output file: $outputfile"
  bsub -J "molconvert" -R "rusage[mem=4028]" -q standard -o "$outputfile.out" -e "$outputfile.err" \
  "molconvert smiles:r1 -T \"name\" "$cxsmiles_file" -o "$outputfile.smi" && \
  tail -n +2 "$outputfile.smi" | tr '\t' ' ' > "$outputfile"_modified.smi && \
  mv "$outputfile"_modified.smi "$outputfile.smi""
  echo "$cxsmiles_file processed at $(date)" >> "$(pwd)/molconvert.log"
done
