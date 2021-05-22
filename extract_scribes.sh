ALL_VMS=$1
OUT_DIR=$2

rm $OUT_DIR/S*
for f in {1..24} 25 27 28 29 30 32 35 36 37 38 42 44 45 47 49 51 \
    52 53 54 56 
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S1
done    
grep '^<f57v' $ALL_VMS >> $OUT_DIR/S1    
for f in {87..90} 93 96 {99..102}
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S1
done

# 85 86 other side of Rosettes
for f in 26 31 33 34 39 40 43 46 50 55 {75..84} 85 86
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S2
done
# first 12 lines of f115r
for i in {1..12}
do
grep '^<f115r\.'$i',' $ALL_VMS >> $OUT_DIR/S2
done

for f in 58 65 94 95
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S3
done

for f in {103..114}
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S3
done
# from line 13 of f115r
for i in {13..45}
do
grep '^<f115r\.'$i',' $ALL_VMS >> $OUT_DIR/S3
done
grep '^<f115v' $ALL_VMS >> $OUT_DIR/S3
grep '^<f116r' $ALL_VMS >> $OUT_DIR/S3

for f in 67 68 69 70 71 72 73
do
grep '^<f'$f'[rv]' $ALL_VMS >> $OUT_DIR/S4
done
grep '^<fRos' $ALL_VMS >> $OUT_DIR/S4

for f in 41r 41v 48r 48v 57r 66r 66v
do
grep '^<f'$f $ALL_VMS >> $OUT_DIR/S5
done
