#!/bin/bash -l

name=grid0.02
L=2.500
N=200
Jmax=10
T=1500
dl=0.02
i=1


while [ $i -le  $N ];
do       
echo $L
# ./h-SH_Duo-intensity_unshifted.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_08brhaho.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_01reor.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_95ma.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_95ma_spinorcomp.csh  $L $T $Jmax $name
./h-SH_Duo-intensity_95ma_v2.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_95ma_shift08brhaho.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_95ma_shift01reor.csh  $L $T $Jmax $name
# ./h-SH_Duo-intensity_goyute.csh $L $T $Jmax $name
./h-SH_abs_exocross.sh $L $T $Jmax $name
./h-SH_lf_exocross.sh  $L $T $Jmax $name
L=`echo $L $dl  | awk  '{printf( "%14.3f\n", $1+$2 )}'`
i=`expr $i + 1`
done;

L=2.500

./h-SH-bin.sh $L $T $Jmax $name $N
