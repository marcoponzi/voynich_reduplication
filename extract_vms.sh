IVTTDIR=~/rec/voynich/software/ivtt

# zodiac labels marked as '_ring'
iconv -f windows-1252 $IVTTDIR/voyn_101.txt | grep -Ev '_ring|\.label' | sed -e 's/<[^>]*>/ /g' |\
    sed -e 's/[-=]$/ /g' | tr '.' ' '> /tmp/conv
cat /tmp/conv | tr -d ',' > texts/vms/all/v101
cat /tmp/conv | tr ',' ' ' > texts/vms/all/v101_u # keep uncertain spaces

# a2=Convert @nnn; codes (rare characters) to a single high ascii byte 
# c5=remove comments
# h1=keep uncertain spaces; h2=ignore uncertain spaces
# s1=blank for spaces
# u1=pick first uncertain reading
# -@L=no Labels
# f0=keep foliation information
# <! page header (removed)

   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h1 -s1 -u1 -@L -f0 +LA > texts/vms/all/EVA_u_A

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h1 -s1 -u1 -@L -f0 +LB > texts/vms/all/EVA_u_B
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +LA > texts/vms/all/EVA_A
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +LB > texts/vms/all/EVA_B
  
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 > texts/vms/all/EVA_all


# SECTION (IGNORING UNCERTAIN SPACES)

# Dummy
echo "" > texts/vms/sections/Unknown

# QA PA f1r; QH PC/D f58r/v
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QA +PA +LA > texts/vms/sections/EVA_HerbA
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PC +LA >> texts/vms/sections/EVA_HerbA
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PD +LA >> texts/vms/sections/EVA_HerbA
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LA >> texts/vms/sections/EVA_HerbA
# Unclassifiable pages as separate section
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QA +PA +LA > texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PC +LA >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PD +LA >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LA > texts/vms/sections_unk/EVA_HerbA

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IP > texts/vms/sections/EVA_Pharma
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IP > texts/vms/sections_unk/EVA_Pharma

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LB > texts/vms/sections/EVA_HerbB
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LB > texts/vms/sections_unk/EVA_HerbB

# QH PE/F f65r/v belong to language B, see https://www.voynich.ninja/thread-3192-post-37291.html#pid37291
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PE >> texts/vms/sections/EVA_HerbB
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PF >> texts/vms/sections/EVA_HerbB
# f66r
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PG >> texts/vms/sections/EVA_HerbB
# Unclassifiable pages as separate section
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PE >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PF >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PG >> texts/vms/sections_unk/Unknown

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IA > texts/vms/sections/EVA_AstroCZ
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IC >> texts/vms/sections/EVA_AstroCZ
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IZ >> texts/vms/sections/EVA_AstroCZ
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IA > texts/vms/sections_unk/EVA_AstroCZ
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IC >> texts/vms/sections_unk/EVA_AstroCZ
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IZ >> texts/vms/sections_unk/EVA_AstroCZ
# f85r1 Text page on the same sheet as Cosmo diagrams
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QN +PB >> texts/vms/sections/EVA_AstroCZ
# Unclassifiable pages as separate section
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QN +PB >> texts/vms/sections_unk/Unknown

# +QT Quire13 / Bio
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QM > texts/vms/sections/EVA_Q13
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QM > texts/vms/sections_unk/EVA_Q13

# +QT Quire20
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QT > texts/vms/sections/EVA_Q20
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QT > texts/vms/sections_unk/EVA_Q20


for text_type in Circular Label Paragraph Radial
do
lett=`echo $text_type | grep -o '^.' `
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 +@$lett -f0 |\
  grep -Ev '<!|#'|sed -e "s/[{}']//g"| sed -e 's/@[0-9][0-9]\([0-9]\);/\1/g' > texts/vms/text_type/$text_type
done
  
for f in texts/vms/all/* texts/vms/sections/* texts/vms/sections_unk/* texts/vms/text_type/*
do
  # convert high ascii bytes to printable characters
  iconv -f Windows-1252 -t utf-8 $f > /tmp/conv
  # remove comments and ligature wrappings
  grep -Ev '<!|#' /tmp/conv |sed -e "s/[{}']//g" > /tmp/out
  mv /tmp/out $f
done

rm texts/vms/scribes/S*
for f in {1..24} 25 27 28 29 30 32 35 36 37 38 42 44 45 47 49 51 \
    52 53 54 56 
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S1
done    
grep '^<f57v' texts/vms/all/EVA_all >> texts/vms/scribes/S1    
for f in {87..90} 93 96 {99..102}
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S1
done

# 85 86 other side of Rosettes
for f in 26 31 33 34 39 40 43 46 50 55 {75..84} 85 86
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S2
done
# first 12 lines of f115r
for i in {1..12}
do
grep '^<f115r\.'$i',' texts/vms/all/EVA_all >> texts/vms/scribes/S2
done

for f in 58 65 94 95
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S3
done

for f in {103..114}
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S3
done
# from line 13 of f115r
for i in {13..45}
do
grep '^<f115r\.'$i',' texts/vms/all/EVA_all >> texts/vms/scribes/S3
done
grep '^<f115v' texts/vms/all/EVA_all >> texts/vms/scribes/S3
grep '^<f116r' texts/vms/all/EVA_all >> texts/vms/scribes/S3

for f in 67 68 69 70 71 72 73
do
grep '^<f'$f'[rv]' texts/vms/all/EVA_all >> texts/vms/scribes/S4
done
grep '^<fRos' texts/vms/all/EVA_all >> texts/vms/scribes/S4

for f in 41r 41v 48r 48v 57r 66r 66v
do
grep '^<f'$f texts/vms/all/EVA_all >> texts/vms/scribes/S5
done



