#!/bin/sh
Gff3File=$1
FastaFile=$2
SpeciesName=$3
GbsFile=${SpeciesName}.gbs

ScriptsAugustus="/home/pabster212/Programs/augustus-3.2.3/scripts/"
GffConv="/home/pabster212/Programs/augustus-3.2.3/scripts/gff2gbSmallDNA.pl"

#echo "${GffConv} ${Gff3File} ${FastaFile} 5000 ${GbsFile}"
#perl ${GffConv} ${Gff3File} ${FastaFile} 5000 ${GbsFile}
#${ScriptsAugustus}randomSplit.pl ${GbsFile} 300
#${ScriptsAugustus}/new_species.pl --species=${SpeciesName}
#etraining --species=${SpeciesName} ${GbsFile}.train
#augustus --species=${SpeciesName} ${GbsFile}.test > First.out
#
#grep -A 22 Evaluation First.out
${ScriptisAugustus}/optimize_augustus.pl --species=${SpeciesName} ${GbsFile}.train 


etraining --species=${SpeciesName} ${GbsFile}.train
augustus --species=${SpeciesName} ${GbsFile}.train > RefinedTest.out








