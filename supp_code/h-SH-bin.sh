#!/bin/bash  -l
#
# Generation of the input file for trove energies
#

L=$1
T=$2
Jmax=$3
name=$4
N=$5

fname=bin-SH_xsec_T${T}-L${L}-J${Jmax}-${name}_95ma_v2

xcross=/scratch/sheena_abigail/j-xsec0107.x

echo $fname

cat<<endb> $fname.inp

Temperature  $T
Range 30000.0  35000 (cm-1)

Npoints 50000

super-lines

absorption 
bin
HWHM 0.1 (cm-1)

output $fname

# (States SH_MRCI_02_L${L}_J${Jmax}.states) 
States SH_MRCI_02_L${L}_J${Jmax}_95ma_v2.states

Transitions
endb
# (ls SH_xsec_T*.xsec >> $fname.inp)
ls SH_xsec_T*_95ma_v2.xsec >> $fname.inp 
echo "end" >> $fname.inp
echo "" >> $fname.inp

$xcross  < $fname.inp > $fname.out 

awk -f xsec-divide.awk N=$N $fname.xsec > ${fname}_aver.xsec




