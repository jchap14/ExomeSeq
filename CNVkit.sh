#!/bin/bash
##### Compare copy number variations using CNVkit

#$ -N CNVkit
#$ -j y
#$ -cwd
#$ -V
#$ -l h_vmem=2G
#$ -pe shm 12
#$ -l h_rt=5:59:00
#$ -l s_rt=5:59:00

## load required modules or conda environment

## define global variables
EXOMETARGETSBED=/srv/gsfs0/projects/snyder/chappell/Annotations/clinical_exome_targets.bed
GENOME=/srv/gsfs0/projects/snyder/chappell/Annotations/UCSC-hg19/WholeGenomeFasta/genome.fa
MAPPABLEHG19=/srv/gsfs0/projects/snyder/chappell/Annotations/UCSC-hg19/access-5k-mappable.hg19.bed

## run command to: "Build a reference from normal samples and infer tumor copy ratios"
# cnvkit.py batch probnd.R1.markdup.realigned.bam \
# 	--normal father.R1.markdup.realigned.bam mother.R1.markdup.realigned.bam \
#     --targets $EXOMETARGETSBED --fasta $GENOME \
#     --access $MAPPABLEHG19 \
#     --output-reference my_reference.cnn --output-dir example/

## run command to: 
cnvkit.py batch probnd.R1.markdup.realigned.bam -r my_reference.cnn -p 12 --scatter --diagram -d example4/

