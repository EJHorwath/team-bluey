#!/bin/bash

#SBATCH --job-name=map_summary # you can give your job a name
#SBATCH --ntasks=24 # the number of processors or tasks
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=10:00:00 # the maximum time for the job
#SBATCH --mem=32gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=/itcgastorage/share_home/t.kielczewski001/1_project/scripts/error/%x-%A.err   # a filename to save error messages into
#SBATCH --output=/itcgastorage/share_home/t.kielczewski001/1_project/scripts/output/%x-%A.out  # a filename to save any printed output into

module load samtools-1.10-gcc-9.3.0-flukja5

# Define the input directory and output directory
input_dir=$1

# Loop through .bam files in the input directory
for file in "$input_dir"/*_sorted.bam; do

 # Extract the base name without the suffix (e.g., "C1_S4_L001")
  base=$(basename "$file" _sorted.bam)

  # Sort the BAM file and output to a new sorted BAM file
  samtools flagstat "$file" > "$input_dir/${base}_summary.txt"
done

echo "Finish Run"
echo "End time: $(date)"

