cat texts/generated/donald_fisk/generated-voynich-manuscript.html | head -4602 | tail -4569 |\
 grep -v '[A-Z]' | sed -e 's/<[^>]*>/ /g' > texts/generated/clean/df
 
 
grep -v '^#' texts/generated/timm_and_schinner/generated_text.txt > texts/generated/clean/ts

cp texts/generated/rene_zandbergen/pliny_mod2.txt texts/generated/clean/rz
