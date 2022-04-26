#!/bin/bash  -l
#
# Generation of the input file for trove energies
#

L=$1
T=$2
Jmax=$3
name=$4

# (fname=SH_xsec_T${T}-L${L}-J${Jmax}-$name)
fname=SH_xsec_T${T}-L${L}-J${Jmax}-${name}_95ma_v2
xcross=/scratch/sheena_abigail/j-xsec0107.x


echo $fname

cat<<endb> $fname.inp

Temperature  $T
Range 30000.0  35000 (cm-1)

Npoints 50000

absorption (emission)
Gaussian  (stick,doppler)
HWHM 0.1 (cm-1)

output $fname

# States  SH_MRCI_02_L${L}_J${Jmax}.states

# Transitions  SH_MRCI_02_L${L}_J${Jmax}.trans

States  SH_MRCI_02_L${L}_J${Jmax}_95ma_v2.states

Transitions  SH_MRCI_02_L${L}_J${Jmax}_95ma_v2.trans

endb

export OMP_NUM_THREADS=8


$xcross < $fname.inp > $fname.out 




