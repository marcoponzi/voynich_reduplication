IVTTDIR=~/rec/voynich/software/ivtt
# a1=@nnn; for special chars, then replaced to 'w'
# c5=remove comments
# h1=keep uncertain spaces; h2=ignore uncertain spaces
# s1=blank for spaces
# u1=pick first uncertain reading
# -@L=no Labels
# f0=keep foliation information

$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h1 -s1 -u1 -@L -f0 +LB |\
  sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_u_B
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h1 -s1 -u1 -@L -f0 +LA |\
  sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_u_A
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 +LA |\
  sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_A
   
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 +LB |\
  sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA_B
  
$IVTTDIR/ivtt $IVTTDIR/ZL_ivtff_1r.txt -a1 -c5 -h2 -s1 -u1 -@L -f0 |\
  sed -e "s/[{}']//g"| sed -e 's/@[0-9]*;/w/g' > texts/vms/EVA

