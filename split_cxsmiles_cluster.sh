#!/bin/bash

function usage {
    echo "Usage: $0 [-h] num_rows"
    echo "Split a CXSMILES file into smaller files with the specified number of rows"
    echo ""
    echo "Arguments:"
    echo "  num_rows       The number of rows to output for each file"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message and exit"
}

# Parse the options
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        *)
            break
            ;;
    esac
done

# Check if the arguments are provided
if [[ $# -ne 1 ]]; then
    echo "Error: Invalid number of arguments"
    usage
    exit 1
fi

# Set the number of rows to output for each file
num_rows="$1"

# Create the output directory if it doesn't exist
output_dir="cxsmiles_split"
if [[ ! -d "$output_dir" ]]; then
    mkdir "$output_dir"
fi

# Loop through all files with a .cxsmiles extension
for input_file in *.cxsmiles; do
  # Extract the input file stem
  input_stem="${input_file%.*}"

  # Launch a job for each input file
  bsub -J "split_${input_stem}" -R rusage[mem=8G] -q standard -o "${output_dir}/${input_stem}_%J.out" -e "${output_dir}/${input_stem}_%J.err" \
  bash -c "tail -n +2 $input_file > ${output_dir}/${input_stem}_noheader.cxsmiles && \
           split -l $num_rows ${output_dir}/${input_stem}_noheader.cxsmiles ${output_dir}/${input_stem}_ -a 7 -d --additional-suffix=.cxsmiles && \
           rm ${output_dir}/${input_stem}_noheader.cxsmiles"

  echo "$input_file processed at $(date)" >> cxsmiles_split.log
done

echo "Done."
