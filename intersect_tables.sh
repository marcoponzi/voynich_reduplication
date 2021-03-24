#SEC_DIR=sections
SEC_DIR=sections_unk

echo -n '_ '
for scr in texts/vms/scribes/*
do
scribe=`echo $scr | sed -e 's%.*/%%'`
echo -n $scribe' '
# INIT PER SCRIBE TOTAL
echo -n 0 > /tmp/scr_$scribe
done
echo TOT_section
echo -n 0 > /tmp/scr_TOT

for sec in EVA_HerbA EVA_Pharma EVA_AstroCZ EVA_HerbB EVA_Q13 EVA_Q20 Unknown
do
secfile=texts/vms/$SEC_DIR/$sec
TOT=0
N=1
echo -n $sec' ' | sed -e 's/EVA_//'
for scr in texts/vms/scribes/*
do
comm -12 <(sort $secfile) <(sort $scr) | sed -e 's/<[^>]*>/ /g' > /tmp/intersection
#N=`echo '1+' $N | bc`
N=`cat /tmp/intersection | wc -w`
echo -n $N' '
scribe=`echo $scr | sed -e 's%.*/%%'`
echo -n + $N >> /tmp/scr_$scribe
TOT=`echo $N '+' $TOT | bc`

done
echo $TOT
echo -n + $TOT >> /tmp/scr_TOT
done

echo -n TOT_scribe' '
for scr in texts/vms/scribes/*
do
scribe=`echo $scr | sed -e 's%.*/%%'`
echo >> /tmp/scr_$scribe
TOT=`cat /tmp/scr_$scribe | bc`
echo -n $TOT' '
done
echo >> /tmp/scr_TOT 
cat /tmp/scr_TOT | bc

