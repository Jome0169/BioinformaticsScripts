#!/usr/bin/env bash

InterPro="/data/pabster212/Programs/interproscan-5.25-64.0/"
InputFasta=$1
SplitNumber=5
BaseName=${InputFasta%.fasta}


python SplitFasta.py -i ${InputFasta} -n ${SplitNumber} -b ${BaseName}

for i in *000* ; do 
    TakeOffFasta=${i%.fasta}
    
    echo "${InterPro}interproscan.sh -i ${i} -f xml -iprlookup -goterms -pa
    --output-file-base ${TakeOffFasta}";

    ${InterPro}interproscan.sh -i ${i} -f xml -iprlookup -goterms -pa \
    --output-file-base ${TakeOffFasta} ;

done




