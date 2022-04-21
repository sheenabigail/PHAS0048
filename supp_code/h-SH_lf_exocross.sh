#!/bin/bash  -l
#
# Generation of the input file for trove energies
#

L=$1
T=$2
J=$3
name=$4

# (fname=SH_lf_T${T}_L${L}_J${J}_$name)
fname=SH_lf_T${T}_L${L}_J${J}_${name}_95ma_spinorcomp
xcross=/scratch/sheena_abigail/j-xsec0107.x

echo $fname

cat<<endb> $fname.inp

lifetime 

output $fname

# (States SH_MRCI_02_L${L}_J${J}.states)

# (Transitions SH_MRCI_02_L${L}_J${J}.trans)
States SH_MRCI_02_L${L}_J${J}_95ma_spinorcomp.states

Transitions SH_MRCI_02_L${L}_J${J}_95ma_spinorcomp.trans

endb

export OMP_NUM_THREADS=8
$xcross < $fname.inp > $fname.out 

# ./j-xsec_2606.x  < $fname.inp > $fname.out 




