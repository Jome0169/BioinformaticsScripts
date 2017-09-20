mitehunter="/home/pabster212/data/Sunhh/src/Annot/MITE_Hunter/MITE_Hunter_blast216/MITE_Hunter_manager.pl"



counter=0
Groupname="Group"

for i in `ls *fasta` ; do
	Newname=${Groupname}${counter}
	echo " mkdir $Newname" 
	mkdir $Newname;
	mv $i $Newname ;
	counter=$((counter+1)); 
	cd $Newname; 
	echo " perl ${mitehunter} -i $i -g Test${counter} -c 30 -n 20 -S 12345678;"
	perl ${mitehunter} -i $i -g Test${counter} -c 30 -n 20 -S 12345678;
	cd ..; done 









