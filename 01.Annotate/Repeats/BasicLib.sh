~/Programs/RepeatMasker/RepeatModeler-open-1.0.10/BuildDatabase -name MelonDat -engine ncbi SpeedMelon.fasta


nohup ~/Programs/RepeatMasker/RepeatModeler-open-1.0.10/RepeatModeler -database MelonDat >& seqfile.out


cd RM_55* 


python ExtractUnknown.py consensi.fa.classified

makeblastdb -in //data/pabster212/citroides_genome/01.Repeats/03.BasicLib/Tpases020812DNA -dbtype prot


echo "blastx -query UnknownRep.lib   -db Tpases020812DNA  -evalue 1e-10 -num_descriptions 10  -out UnknownRepeat.blast"
blastx -query UnknownRep.lib -db //data/pabster212/citroides_genome/01.Repeats/03.BasicLib/Tpases020812DNA  -evalue 1e-10 -num_descriptions 10  -out UnknownRepeat.blast



echo " perl /home/pabster212/Programs/gt-1.5.9-Linux_x86_64-64bit-complete/CRL_scripts//transposon_blast_parse.pl --blastx UnknownRepeat.blast --modelerunknown UnknownRep.lib
#"
perl \
/home/pabster212/Programs/gt-1.5.9-Linux_x86_64-64bit-complete/CRL_scripts//transposon_blast_parse.pl \
--blastx UnknownRepeat.blast --modelerunknown UnknownRep.lib


echo " cat identified_elements.txt KnownRep.lib > AllKnownElements.lib"
cat identified_elements.txt KnownRep.lib > AllKnownElements.lib


mv  unknown_elements.txt  ModelerUnknown.lib
mv AllKnownElements.lib ..
mv ModelerUnknown.lib ..


cd ..

echo " blastx -query ModelerUnknown.lib repeatmodeler  -db  uniprotnotransp.fasta -evalue 1e-10 -num_descriptions 10 -out UknownModel.blast"
blastx -query ModelerUnknown.lib  -db  uniprotnotransp.fasta -evalue 1e-10 -num_descriptions 10 -out UknownModel.blast


Yup="perl ProtExcluder1.1/ProtExcluder.pl"
echo " ProtExcluder1.1/ProtExcluder.pl  -f 50 Ukno UknownModel.blasdt ModelerUnknown.lib"
${Yup} -f 50  UknownModel.blasdt ModelerUnknown.lib

cat ModelerUnknown.libnoProtFinal AllKnownElements.lib > BasicRepLibFinal.lib


mv BasicRepLibFinal.lib Final













