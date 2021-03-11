Language text corpus collected by Brian Cham:
  https://briancham1994.com/voynich-resources/

Voynich transliteration by Zandbergen and Landini
  http://www.voynich.nu/data/


```
Needed packages:
pip3 install adjustText
pip3 install Levenshtein


Full versus Partial Reduplication; Cham's corpus and VMS:

python3 redup_stats.py texts/brian_cham_utf8/* texts/vms/EVA*


Removing the PML file:

python3 redup_stats.py `ls -1 texts/brian_cham_utf8/*|grep -v PML` texts/vms/EVA*

Full versus Partial Reduplication % per scribe:

python3 redup_stats.py texts/vms/scribes/S*

Triple reduplication:

python3 redup_stats.py `ls -1 texts/brian_cham_utf8/*|grep -v PML` texts/vms/EVA* texts/generated/clean/df texts/generated/clean/ts

```

TODO:
add synthetic vms (TS, Fisk, mod2)
logging of weird characetrs (e.g. CZE LIT)
