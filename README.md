Language text corpus collected by Brian Cham:
  https://briancham1994.com/voynich-resources/

Voynich transliteration by Zandbergen and Landini
  http://www.voynich.nu/data/

v101 transliteration:
  http://www.voynich.nu/data/voyn_101.txt

Donald Fisk's generated text:
  https://www.fmjlang.co.uk/voynich/generated-voynich-manuscript.txt

```
Needed packages:
pip3 install adjustText
pip3 install Levenshtein


Full versus Partial Reduplication; Cham's corpus and VMS:

python3 redup_stats.py redup_scatter texts/brian_cham_utf8/* texts/vms/all/* texts/generated/clean/*


Removing the PML and Rene Zanbergen's files (outliers):

python3 redup_stats.py redup_scatter `ls -1 texts/brian_cham_utf8/* texts/vms/all/* texts/generated/clean/* | grep -Ev 'PML|rz'`

Full versus Partial Reduplication % per scribe:

python3 redup_stats.py redup_scatter texts/vms/all/scribes/S*

Triple reduplication:

python3 redup_stats.py redup_scatter `ls -1 texts/brian_cham_utf8/*|grep -v PML` \
  texts/vms/all/* texts/generated/clean/df texts/generated/clean/ts
  
Scrambled:

python3 redup_stats.py scramble texts/brian_cham_utf8/* texts/vms/all/* texts/generated/clean/*

Removing outliers:

python3 redup_stats.py scramble `ls -1 texts/brian_cham_utf8/* texts/vms/all/* texts/generated/clean/* | grep -Ev 'PML|EMY|rz'`

for f in texts/vms/all/EVA_all texts/vms/all/v101 texts/vms/all/EVA_Q20 texts/generated/clean/ts texts/generated/clean/df \
     texts/brian_cham_utf8/LZH texts/brian_cham_utf8/VIE texts/brian_cham_utf8/JPN 
do 
  python3 redup_stats.py redup_by_rank $f
done

Correlation plots for scribes and illustrations:

python3 redup_stats.py correlation texts/vms/scribes/*; xviewer `ls -1 out/corr* | tail -1`
python3 redup_stats.py correlation texts/vms/illustrations/*; xviewer `ls -1 out/corr* | tail -1`

TODO:

bifolio correlation
across lines / image breaks

