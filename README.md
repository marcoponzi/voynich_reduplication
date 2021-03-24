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

for f in texts/vms/all/EVA_all texts/vms/all/v101 texts/vms/all/EVA_Q20 texts/generated/clean/ts texts/generated/clean/df \
     texts/brian_cham_utf8/LZH texts/brian_cham_utf8/VIE texts/brian_cham_utf8/JPN 
do 
  python3 redup_stats.py redup_by_rank $f
done


```

TODO:
logging of weird characetrs (e.g. CZE LIT)
handling high ascii values in ZL
GC ivtt as a source for v101
scrambled plots 
