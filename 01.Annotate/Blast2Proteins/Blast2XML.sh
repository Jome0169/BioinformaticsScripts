GenomeProt=$1
Database=$2
Split=10
DBBaseName=${Database%.fa*}

FileBase="MELON"

makeblastdb -in ${Database} -dbtype prot

python SplitFasta.py -i ${GenomeProt} -n ${Split} -b ${FileBase}
#blastp -outfmt 6 -query query_sequences_AA.fasta -db uniprot_swissprot.fasta -out query_vs_swissprot.txt


for i in *000* ; do 
    NewBaseName=${i%.fa*} ;

    blastp -outfmt 11 -query ${i} -db ${Database} -evalue 1e-3 -num_alignments 20  -num_threads 5 -out ${DBBaseName}_vs_${NewBaseName}.asn.1 &

done 


wait


for i in *000*; do 
    
    NewBaseName=${i%.fa*} ;
    blast_formatter -archive  ${DBBaseName}_vs_${NewBaseName}.asn.1 \
    -outfmt 5 \
    -out ${DBBaseName}_vs_${NewBaseName}.xml &

done 




