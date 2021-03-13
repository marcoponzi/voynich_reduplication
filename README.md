Language text corpus collected by Brian Cham:
  https://briancham1994.com/voynich-resources/

Voynich transliteration by Zandbergen and Landini
  http://www.voynich.nu/data/

v101 transliteration:
  http://www.voynich.nu/data/voyn_101.txt

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

```

TODO:
logging of weird characetrs (e.g. CZE LIT)
