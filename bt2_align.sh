
#!/bin/bash
set -e
set -u
set -o pipefail

# Build index with FASTA file.
bowtie2-build hg38.fa index
# Align
fastq=($(ls *.sam))
for file in ${fastq[@]}
do
    file_name"$(basename $file .fastq)"
    bowtie2 --no-unal --threads 4 -x index/index -U $file -S ${file_name}.sam
done

# Convert to sorted indexed BAM
files=($(ls *.sam))
for file in ${files[@]}
do
    file_name="$(basename $file .sam)"
    samtools view -b $file > ${file_name}.bam &
done
wait

for file in ${files[@]}
do
    file_name="$(basename $file .sam)"
    samtools sort ${file_name}.bam -o ${file_name}_sorted.bam &
done
wait

for file in ${files[@]}
do
    file_name="$(basename $file .sam)"
    samtools index ${file_name}_sorted.bam
done
wait

