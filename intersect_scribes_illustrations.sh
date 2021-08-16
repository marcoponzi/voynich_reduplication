rm texts/vms/scribe_and_illustr/S*
for scribe in 1 2 3 4 5
do
  for illustrationf in texts/vms/illustrations/EVA_*
  do
  fname=`echo $illustrationf | sed -e 's%.*/%%'`
  outf=texts/vms/scribe_and_illustr/S$scribe'_'$fname
  awk 'NR==FNR { lines[$0]=1; next } $0 in lines' texts/vms/scribes/S$scribe $illustrationf > \
    $outf
    
  if [ -s $outf ]; then
        # The file is not-empty.
	echo $outf
  else
        # The file is empty.
        rm -f $outf
  fi
  done
done
