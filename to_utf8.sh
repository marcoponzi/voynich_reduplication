CHAMDIR=~/rec/voynich/researchers/briancham/natural_language_sample_pack
mkdir /tmp/cham
rm /tmp/cham/*
cp $CHAMDIR/* /tmp/cham
# remove words in parenthesis from JPN text (they look like alternative spellings)
sed -e 's/ *([^)]*) */ /g' $CHAMDIR/N-JPN.txt > /tmp/cham/N-JPN.txt
# remove line numbers from Sanskrit file
sed -e 's/^.\..\...\?.\? / /' $CHAMDIR/N-SAN.txt > /tmp/cham/N-SAN.txt
# remove spurious ' o ' from EMY Chotli Vocabulario
sed -e 's/ o / /g' $CHAMDIR/N-EMY.txt > /tmp/cham/N-EMY.txt

# 54 files: 51 are processed
# ignore the two 'original' files with non-romanized ideograms
# ignore CUR: a transliteration of birdsong
for f in `ls /tmp/cham/* | grep -Ev 'CUR|original'`
do
  fname=`echo $f | sed -e 's%.*/%%'| sed -e 's%N-%%' | sed -e 's%.txt%%' `
  echo $fname
  iconv -t UTF-8 "$f" > /tmp/conv
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
    echo success
  else
    # Windows-1252 aka ANSI
    # see https://www.w3schools.com/html/html_charset.asp
    iconv -f Windows-1252 -t UTF-8 "$f" > /tmp/conv
  fi
  # remove [,(,),] replace other punctuation with space
  # keep \n and replace all other whitespace with ' '
  sed -e 's/[()]//g' /tmp/conv | tr '[:punct:]' ' ' | sed -e 's/[•– —。；“”、：，«»´։’·]/ /g' |
     tr '\n' ';' | tr '[:space:]' ' ' | tr ';' '\n' | tr '[:upper:]' '[:lower:]' > texts/brian_cham_utf8/$fname # # to lowercase
done

sed -e 's/‹/ï/g' texts/brian_cham_utf8/ITA > /tmp/out
mv /tmp/out texts/brian_cham_utf8/ITA

