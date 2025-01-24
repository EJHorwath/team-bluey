#!/bin/bash

#SBATCH --job-name=Taylor_Trim # you can give your job a name
#SBATCH --nodes 2 # the number of processors or tasks
#SBATCH --cpus-per-task=2
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=1:00:00 # the maximum time for the job
#SBATCH --mem=4gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=logs/error%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/output%x-%A.out  # a filename to save any printed output into

# Usage: sbatch cutadapt.sh path/to/input_dir path/to/output_dir
# Works for paired end reads where both end in the same *_001_downsampled.fastq

# Module load
module load py-dnaio-0.4.2-gcc-10.2.0-gaqzhv4
module load py-xopen-1.1.0-gcc-10.2.0-5kpnvqq
module load py-cutadapt-2.10-gcc-10.2.0-2x2ytr5

# Define variables
input_dir=$1 # takes this from the command line, first item after the script
output_dir=$2 # takes this from the command line, second item

for R1_fastq in ${input_dir}/*6_1.fastq
 do
 # Pull basename
 name=$(basename ${R1_fastq} 6_1.fastq)

 # Run cutadapt
 cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
 -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --trim-n -m 25 \
 -o ${output_dir}/${name}6_1_trim.fastq \
 -p ${output_dir}/${name}6_2_trim.fastq \
 ${input_dir}/${name}6_1.fastq \
 ${input_dir}/${name}6_2.fastq

 echo cutadapt is finished with $name

done
