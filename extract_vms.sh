IVTTDIR=~/rec/voynich/software/ivtt
# a1=@nnn; for special chars, then replaced to 'w'
# c5=remove comments
# h1=keep uncertain spaces; h2=ignore uncertain spaces
# s1=blank for spaces
# u1=pick first uncertain reading
# -@L=no Labels
# f0=keep foliation information
# <! page header (removed)

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h1 -s1 -u1 -@L -f0 +LB |\
  grep -v '<!'|sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_u_B
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h1 -s1 -u1 -@L -f0 +LA |\
  grep -v '<!'|sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_u_A
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 +LA |\
  grep -v '<!'|sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_A
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 +LB |\
  grep -v '<!'|sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_B
  
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 |\
  grep -Ev '<!|#'|sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA

rm texts/vms/scribes/S*
for f in {1..24} 25 27 28 29 30 32 35 36 37 38 42 44 45 47 49 51 \
    52 53 54 56 
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S1
done    
grep '^<f57v' texts/vms/EVA >> texts/vms/scribes/S1    
for f in {87..90} 93 96 {99..102}
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S1
done

# 85 86 other side of Rosettes
for f in 26 31 33 34 39 40 43 46 50 55 {75..84} 85 86
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S2
done
# first 12 lines of f115r
for i in {1..12}
do
grep '^<f115r\.'$i',' texts/vms/EVA >> texts/vms/scribes/S2
done

for f in 58 65 94 95
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S3
done

for f in {103..114}
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S3
done
# from line 13 of f115r
for i in {13..45}
do
grep '^<f115r\.'$i',' texts/vms/EVA >> texts/vms/scribes/S3
done
grep '^<f115v' texts/vms/EVA >> texts/vms/scribes/S3
grep '^<f116r' texts/vms/EVA >> texts/vms/scribes/S3

for f in 67 68 69 70 71 72 73
do
grep '^<f'$f'[rv]' texts/vms/EVA >> texts/vms/scribes/S4
done
grep '^<fRos' texts/vms/EVA >> texts/vms/scribes/S4

for f in 41r 41v 48r 48v 57r 66r 66v
do
grep '^<f'$f texts/vms/EVA >> texts/vms/scribes/S5
done




