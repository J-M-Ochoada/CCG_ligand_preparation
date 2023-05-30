#!/bin/bash
module load moe/2022.02

for file in *.smi; do
  outputfile="${file%.*}"
  mkdir -p MDB
  bsub -J "dbOpen" -R rusage[mem=2048] -q standard -o "MDB/$outputfile"_MDB.out -e "MDB/$outputfile"_MDB.err \
  "moebatch -exec \"db_Open['MDB/"$outputfile".mdb','create']"\"
  #"moebatch -exec \"db_ImportASCII[ascii_file:'"$file"', db_file:'MDB/"$outputfile".mdb', delimeter:' ', quotes:0, field_names:['field1', 'field2'], field_types:['molecule', 'char']]]"\"
done

for file in *.smi; do
  outputfile="${file%.*}"
  bsub -J "dbImport" -R rusage[mem=2048] -q standard -o "MDB/$outputfile"_MDB.out -e "MDB/$outputfile"_MDB.err \
  "moebatch -exec \"db_ImportASCII[ascii_file:'"$file"', db_file:'MDB/"$outputfile".mdb', delimeter:' ', quotes:0, titles:0, names:['mol', 'name'], types:['molecule', 'char']];\""
done
