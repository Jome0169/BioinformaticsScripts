GffFIle=""
GenomeFile=""



#/home/pabster212/Programs/maker/exe/snap/fathom genome.ann genome.dna \
#-gene-stats > gene-stats.log 2>&1
#
#
#/home/pabster212/Programs/maker/exe/snap/fathom genome.ann genome.dna -validate
#> validate.log 2>&1
#
#


echo "/home/pabster212/Programs/maker/exe/snap/fathom genome.ann genome.dna \
-categorize 1000 > categorize.log 2>&1"

/home/pabster212/Programs/maker/exe/snap/fathom genome.ann genome.dna \
-categorize 1000 > categorize.log 2>&1

echo "/home/pabster212/Programs/maker/exe/snap/fathom uni.ann uni.dna -export 1000 \
-plus > uni-plus.log 2>&1"

/home/pabster212/Programs/maker/exe/snap/fathom uni.ann uni.dna -export 1000 \
-plus > uni-plus.log 2>&1


mkdir params
cd params 
/home/pabster212/Programs/maker/exe/snap/forge ../export.ann ../export.dna > ../forge.log 2>&1



cd ..
/home/pabster212/Programs/maker/exe/snap/hmm-assembler.pl citroides  params/ > Melon.hmm


