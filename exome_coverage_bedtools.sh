##### Check breadth and depth of coverage for exome seq

# for x in `/bin/ls *.markdup.realigned.bam` ; do bash exome_coverage_bedtools.sh $x; done
# for x in `/bin/ls *.bam` ; do bash exome_coverage_bedtools.sh $x; done

## add modules
#module add bedtools/2.16.2

## define variables
BAMFILE=$1
TARGETBED="/srv/gsfs0/projects/snyder/chappell/Annotations/clinical_exome_targets.bed"
#NAME=`basename $1 .markdup.realigned.bam`
NAME=`basename $1 .bam`


cat > $NAME.tempscript.sh << EOF
#!/bin/bash -l
#SBATCH --job-name $NAME.coverage
#SBATCH --output=$NAME.coverage.out
#SBATCH --mail-user jchap14@stanford.edu
#SBATCH --mail-type=ALL
# Request run time & memory
#SBATCH --time=5:00:00
#SBATCH --mem=6G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --export=ALL
#SBATCH --account=mpsnyder

##### Run commands:
##usage: coverageBed [OPTIONS] -a <BED/GFF/VCF> -b <BED/GFF/VCF>
echo \`bedtools -version\`
bedtools coverage -hist -abam $BAMFILE -b $TARGETBED | grep ^all > $NAME.bam.hist.all.txt
EOF

## qsub then remove the tempscript
sbatch $NAME.tempscript.sh #scg
sleep 1
# rm $NAME.tempscript.sh

##### test command: use bedtools version 2.16.2
# bamfile="M4.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt
# 
# bamfile="MC.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt
# 
# bamfile="P4.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt
# 
# bamfile="PC.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt
# 
# bamfile="FC.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt
# 
# bamfile="F1.trim.R1.markdup.realigned.bam"
# name=`basename $bamfile .trim.R1.markdup.realigned.bam`
# bedtools coverage -hist -abam $bamfile -b clinical_exome_targets.bed | grep ^all > $name.bam.hist.all.txt