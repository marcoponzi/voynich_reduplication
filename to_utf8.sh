# 54 files: 51 are processed
# ignore the two 'original' files with non-romanized ideograms
# ignore CUR: a transliteration of birdsong
for f in `ls ~/rec/voynich/researchers/briancham/natural_language_sample_pack/* | grep -Ev 'CUR|original'`
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
  cp /tmp/conv texts/brian_cham_utf8/$fname
done

sed -e 's/‹/ï/g' texts/brian_cham_utf8/ITA > /tmp/out
mv /tmp/out texts/brian_cham_utf8/ITA
