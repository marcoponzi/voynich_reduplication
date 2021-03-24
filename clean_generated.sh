cat texts/generated/donald_fisk/generated-voynich-manuscript.txt | grep -v '[A-Z]'> texts/generated/clean/df

cat texts/generated/donald_fisk/generated-voynich-manuscript.txt | sed -e '1,2703d'> texts/generated/clean/df_text_q20
 
grep -v '^#' texts/generated/timm_and_schinner/generated_text.txt > texts/generated/clean/ts

cp texts/generated/rene_zandbergen/pliny_mod1.txt texts/generated/clean/rz1
cp texts/generated/rene_zandbergen/pliny_mod2.txt texts/generated/clean/rz2
