### Basic functions.
function exe_cmd {
        echo "[$(date)][CMD] $1"
        eval "$1"
        echo "[$(date)][Rec] Done."
}

function tsmsg {
        echo "[$(date)]$1"
}

pl_goodWrn="$HOME/tools/github/NGS_data_processing/annot_tools/snap_good_wrn_by_valid.pl"
dir_snap='/data/Sunhh/src/Annot/maker/2.31.9/maker/exe/snap/'
export PATH="$dir_snap:$PATH"

ovl_len=2000

in_gff='cand_finalUse_flank2k.scfID_wiFa.gff3'
org_name=BG
useTag='BGIsland2kb'
ohmm_name=BG.${useTag}.hmm

exe_cmd "maker2zff -n $in_gff"
# exe_cmd "maker2zff -x 0 -o 1 -c 1 -l 30 $in_gff"
exe_cmd "fathom genome.ann genome.dna -validate   > genome.fat_valid"
exe_cmd "fathom genome.ann genome.dna -gene-stats > genome.fat_stats"
exe_cmd "fathom -categorize $ovl_len genome.ann genome.dna"
exe_cmd "perl $pl_goodWrn -valid genome.fat_valid -wrnDna wrn.dna -wrnAnn wrn.ann -yaN 2 -outPref wrnGood"
exe_cmd "cat uni.dna wrnGood.dna > ${useTag}.dna ; cat uni.ann wrnGood.ann > ${useTag}.ann"
exe_cmd "fathom ${useTag}.ann ${useTag}.dna -validate   > ${useTag}.fat_valid"
exe_cmd "fathom ${useTag}.ann ${useTag}.dna -gene-stats > ${useTag}.fat_stats"
exe_cmd "fathom -export $ovl_len -plus ${useTag}.ann ${useTag}.dna"
exe_cmd "fathom export.ann export.dna -validate   > export.fat_valid"
exe_cmd "fathom export.ann export.dna -gene-stats > export.fat_stats"
exe_cmd "mkdir parameters"
exe_cmd "cd parameters ; forge ../export.ann ../export.dna ; cd ../"
exe_cmd "hmm-assembler.pl $org_name parameters > $ohmm_name"

tsmsg "rm -rf genome.??? wrn.??? alt.??? olp.??? err.??? wrnGood.??? parameters/"

