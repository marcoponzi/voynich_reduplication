IVTTDIR=~/rec/voynich/software/ivtt

# zodiac labels marked as '_ring'
iconv -f Windows-1252 -t utf-8 $IVTTDIR/voyn_101.txt | grep -Ev '_ring|\.label' | sed -e 's/<[^>]*>/ /g' |\
    sed -e 's/[-=]$/ /g' | tr '.' ' '> /tmp/conv
cat /tmp/conv | tr -d ',' > texts/vms/all/v101
cat /tmp/conv | tr ',' ' ' > texts/vms/all/v101_u # keep uncertain spaces

$IVTTDIR/ivtt $IVTTDIR/GC_ivtff_0c.txt -a2 -c5 -h1 -s1 -u1 -@L -f0 > texts/vms/all/v101_u
$IVTTDIR/ivtt $IVTTDIR/GC_ivtff_0c.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 > texts/vms/all/v101


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

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h1 -s1 -u1 -@L -f0 > texts/vms/all/EVA_all_u  
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

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LB > texts/vms/sections/EVA_HerbB
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH +LB > texts/vms/sections_unk/EVA_HerbB

# QH PE/F f65r/v belong to language B, see https://www.voynich.ninja/thread-3192-post-37291.html#pid37291
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PE >> texts/vms/sections/EVA_HerbB
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PF >> texts/vms/sections/EVA_HerbB

# f66r
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PG >> texts/vms/sections/EVA_HerbB

for dir in sections sections_unk illustrations
do
  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IP > texts/vms/$dir/EVA_Pharma

  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IA > texts/vms/$dir/EVA_AstroCZ
  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IC >> texts/vms/$dir/EVA_AstroCZ
  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IZ >> texts/vms/$dir/EVA_AstroCZ

  # +QT Quire13 / Bio
  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QM > texts/vms/$dir/EVA_Q13

  # +QT Quire20
  $IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QT > texts/vms/$dir/EVA_Q20
done


# "illustrations" splits pages purely by illustration type +I
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IH > texts/vms/illustrations/EVA_Herbal
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +IT >> texts/vms/illustrations/EVA_Text


# Unclassifiable pages as separate section
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PE >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PF >> texts/vms/sections_unk/Unknown
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QH +PG >> texts/vms/sections_unk/Unknown

# f85r1 Text page on the same sheet as Cosmo diagrams
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QN +PB >> texts/vms/sections/EVA_AstroCZ
# Unclassifiable pages as separate section
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 -@L -f0 +QN +PB >> texts/vms/sections_unk/Unknown




for text_type in Circular Label Paragraph Radial
do
lett=`echo $text_type | grep -o '^.' `
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a2 -c5 -h2 -s1 -u1 +@$lett -f0 |\
  grep -Ev '<!|#'|sed -e "s/[{}']//g"| sed -e 's/@[0-9][0-9]\([0-9]\);/\1/g' > texts/vms/text_type/$text_type
done
  
for f in texts/vms/all/* texts/vms/sections/* texts/vms/sections_unk/* texts/vms/text_type/* texts/vms/illustrations/*
do
  # convert high ascii bytes to printable characters
  iconv -f Windows-1252 -t utf-8 $f > /tmp/conv
  # remove comments and ligature wrappings
  grep -Ev '<!|#' /tmp/conv |sed -e "s/[{}']//g" > /tmp/out
  mv /tmp/out $f
done

source ./extract_scribes.sh texts/vms/all/EVA_all texts/vms/scribes/



