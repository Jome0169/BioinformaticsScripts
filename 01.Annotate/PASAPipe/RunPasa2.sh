TrinityDeNovo="trinity_novo01.Trinity.fasta"
TrinityGenomeGuided="Trinity-GG.fasta"
TrinityTotal="CombinedTransCombinedTrans.fasta"
GenomeFile="SpeedMelon.fasta"



#cat ${TrinityDeNovo} ${TrinityGenomeGuided} > ${TrinityTotal}
#perl /home/pabster212/Programs/PASApipeline/misc_utilities/accession_extractor.pl < ${TrinityDeNovo} > tdn.accs
#
#
#
#seqclean ${TrinityTotal} -v /home/pabster212/Programs/PASApipeline/seqclean/UniVec



#echo "perl /home/pabster212/Programs/PASApipeline/scripts/Launch_PASA_pipeline.pl --CPU 50 -c alignAssembly.config -C -r -R -g ${GenomeFile} --ALIGNERS blat,gmap -t ${TrinityTotal}.clean -T -u ${TrinityTotal} --transcribed_is_aligned_orient --stringent_alignment_overlap 30.0 --TDN tdn.accs --TRANSDECODER "






## Sub-step:
#/data/Sunhh/src/Annot/PASA/PASApipeline-2.0.1/scripts/..//scripts/assemble_clusters.dbi
#-G P1All.scf.forPASA.fa  -M P1denovoAndGG_pasa  -T 1  >
#P1denovoAndGG_pasa.pasa_alignment_assembly_building.ascii_illustrations.out

##### File descriptions : 
# BG_pasa.assemblies.fasta               : the PASA assemblies in FASTA format.
# This might be used as a comprehensive EST dataset. 
# BG_pasa.pasa_assemblies.gff3,.gtf,.bed : the PASA assembly structures. This
# stores the alignments. 
# BG_pasa.pasa_alignment_assembly_building.ascii_illustrations.out :
# descriptions of alignment assemblies and how they were constructed from the
# underlying transcript alignments. 
# BG_pasa.pasa_assemblies_described.txt  : tab-delimited format describing the
# contents of the PASA assemblies, including the identity of those transcripts
# that were assembled into the corresponding structure. 

# After generating pasa assemblies, further build comprehensive transcriptome
# database. 

echo " perl /home/pabster212/Programs/PASApipeline/scripts/build_comprehensive_transcriptome.dbi -c alignAssembly.config -t ${TrinityDeNovo} --min_per_ID 95 --min_per_aligned 30"
perl /home/pabster212/Programs/PASApipeline/scripts/build_comprehensive_transcriptome.dbi -c alignAssembly.config -t ${TrinityTotal} --min_per_ID 95 --min_per_aligned 30


echo " perl /home/pabster212/Programs/PASApipeline/scripts/pasa_asmbls_to_training_set.dbi -S --pasa_transcripts_fasta Melon_pasa.assemblies.fasta --pasa_transcripts_gff3 Melon_pasa.pasa_assemblies.gff4"
perl /home/pabster212/Programs/PASApipeline/scripts/pasa_asmbls_to_training_set.dbi -S --pasa_transcripts_fasta Melon_pasa.assemblies.fasta --pasa_transcripts_gff3 Melon_pasa.pasa_assemblies.gff3

# Resulting files : BG_pasa.assemblies.fasta.transdecoder.*
# Typically, we would search these complete proteins against the non-redundant
# protein database at GenBank and identify those ORFs that have good database
# matches across most of their length.










#mkdir filter_by_ProtDB/
#deal_fasta.pl BG_pasa.assemblies.fasta.transdecoder.pep -attr key:head | grep
#' type:complete ' > filter_by_ProtDB/cand_list
#deal_fasta.pl BG_pasa.assemblies.fasta.transdecoder.pep -drawByList -drawList
#filter_by_ProtDB/cand_list -drawLcol 0 -drawWhole >
#filter_by_ProtDB/cand_prot.fa
#
#cd filter_by_ProtDB/
#ln -s
#/home/Sunhh/tools/github/NGS_data_processing/annot_tools/find_complete_prot_byBlastp.pl
#. 
#perl find_complete_prot_byBlastp.pl -topNhits 5 -blastp_para ' -evalue 1e-5
#-seg yes -num_threads 30 ' -dist2left 0 -dist2right 2 -minIdentity 75 -prot_qry
#cand_prot.fa -opref cand_prot_toCS -prot_db db/CS_v2.prot_represent.fasta
#perl find_complete_prot_byBlastp.pl -topNhits 5 -blastp_para ' -evalue 1e-5
#-seg yes -num_threads 30 ' -dist2left 0 -dist2right 2 -minIdentity 75 -prot_qry
#cand_prot.fa -opref cand_prot_toCM -prot_db db/CM_v3.5.prot_represent.fasta
#perl find_complete_prot_byBlastp.pl -topNhits 5 -blastp_para ' -evalue 1e-5
#-seg yes -num_threads 30 ' -dist2left 0 -dist2right 2 -minIdentity 75 -prot_qry
#cand_prot.fa -opref cand_prot_toWM -prot_db db/WM97v1.prot.fa
#deal_table.pl -column 0 cand_prot_toCS.bp6.complete | deal_table.pl
#-UniqColLine 0 | deal_table.pl -kSrch_idxCol 0 -kSrch_srcCol 0 -kSrch_idx
#cand_prot_toCM.bp6.complete | deal_table.pl -kSrch_idxCol 0 -kSrch_srcCol 0
#-kSrch_idx cand_prot_toWM.bp6.complete > cand_prot_complete_ID
#deal_fasta.pl cand_prot.fa -drawByList -drawList cand_prot_complete_ID
#-drawLcol 0 -drawWhole > cand_prot_complete_prot.fa
#
#ln -s
#/home/Sunhh/tools/github/NGS_data_processing/annot_tools/rmRedunt_inputProt.pl
#.
#perl rmRedunt_inputProt.pl -prot_qry cand_prot_complete_prot.fa -opref
#cand_prot_complete_rmRedund -blastp_para ' -evalue 1e-5 -seg yes -num_threads
#30 ' -minIdentity 70
#deal_fasta.pl cand_prot_complete_prot.fa -attr key:len | deal_table.pl
#-kSrch_idx cand_prot_complete_rmRedund.bp6.redund_list -kSrch_drop
#-kSrch_idxCol 0 -kSrch_srcCol 0 > cand_prot_complete_prot_rmRed_list
#deal_fasta.pl cand_prot_complete_prot.fa -drawByList -drawList
#cand_prot_complete_prot_rmRed_list -drawWhole -drawLcol 0 >
#cand_finalUse.prot.fa
#deal_fasta.pl ../BG_pasa.assemblies.fasta.transdecoder.cds -drawByList
#-drawList cand_prot_complete_prot_rmRed_list -drawWhole -drawLcol 0 >
#cand_finalUse.cds.fa
#
#ln -s ../BG_pasa.assemblies.fasta.transdecoder.genome.gff3 .
#perl gff_by_list.pl cand_prot_complete_prot_rmRed_list
#BG_pasa.assemblies.fasta.transdecoder.genome.gff3 > cand_finalUse.genome.gff3
#deal_table.pl cand_finalUse.genome.gff3 -chID_RefLis BG.scf.fa.key2key
#-chID_OldColN 0 -chID_NewColN 1 -chID_Row -chID_RowColN 0 >
#cand_finalUse.scfID.gff3
#
#gff2gbSmallDNA.pl cand_finalUse.scfID.gff3 ../../ws_bg_spaln/BG.scf.fa 2000
#cand_finalUse.scfID.gb
#
#perl good_model_from_gff3.pl -seedGff cand_finalUse.genome.gff3 -bgGff
#BG_pasa.assemblies.fasta.transdecoder.genome.gff3 -flankSize 2000 -flankSize
#3000 -flankSize 4000 -flankName 2k -flankName 3k -flankName 4k -pl_dg
#/home/Sunhh/tools/github/NGS_data_processing/temp/deal_gff3.pl 
#nohup perl good_model_from_gff3.pl -seedGff cand_finalUse.genome.gff3 -bgGff
#BG_pasa.assemblies.fasta.transdecoder.genome.gff3 -flankSize 500 -flankName 5h
#-pl_dg /home/Sunhh/tools/github/NGS_data_processing/temp/deal_gff3.pl
#perl ~/tools/github/NGS_data_processing/temp/deal_gff3.pl -inGff
#cand_finalUse.genome.gff3 -gffret good.0.5h.ID -idType mRNA -out
#cand_finalUse_flank5h.genome.gff3
#perl ~/tools/github/NGS_data_processing/temp/deal_gff3.pl -inGff
#cand_finalUse.genome.gff3 -gffret good.0.2k.ID -idType mRNA -out
#cand_finalUse_flank2k.genome.gff3

