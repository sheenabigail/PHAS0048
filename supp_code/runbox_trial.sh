#This script has been designed to modify the values of 'j' and maximum range values in duo input files and ultimately produce data of lifetimes of the A2Sigma+ state
#To see an examples of the modifiable input files see: sergeypoten_95ma_soc_amc_85sewerore_dmc_r.inp (duo input) and SH_01_lifetime.inp (exocross input)
###REMINDER###
###adjust all the directory lines to appropriate ones###

#!/bin/bash

module load intel/ics2020
#name of input file
input=$1
#maximum value of j
jval=$2
#end value of range
range=$3
#step value
stepval=$4
#max value of range
maxrange=$5

#So running the command would look like 'sh runbox.sh <input file name without extension> <jval> <range> <stepval> <maxrange>'

for i in $(seq "$range" "$stepval" "$maxrange")
do
#Creating modified duo input files, saving them to duo_inp
sed -e "s/@rend/"$i"/g; s/@jval/"$jval"/g" "$input".inp> /home/standjung/masterscript/duo_inp/"$input"_"$i"_j_"$jval".inp 
#Running duo, saving the .out files to duo_out
/home/standjung/phas0048/Duo-master/j-duo-v218.v1.x </home/standjung/masterscript/duo_inp/"$input"_"$i"_j_"$jval".inp>/home/standjung/masterscript/duo_out/"$input"_"$i"_j_"$jval".out
#Creating modified exocross lifetime input files, saving them to exocross_inp
sed -e "s/@rend/"$i"/g; s/@out/"$input"/g; s/@jval/"$jval"/g" /home/standjung/SH_01_lifetime.inp> /home/standjung/masterscript/exocross_inp/"$input"_"$i"_j_"$jval"_lifetime.inp
#Running exocross, saving the .out files to exocross_out
/home/standjung/phas0048/exocross-master/xcross.exe </home/standjung/masterscript/exocross_inp/"$input"_"$i"_j_"$jval"_lifetime.inp>/home/standjung/masterscript/exocross_out/"$input"_"$i"_j_"$jval"_lifetime.out
#Saving lifetimes for A2Sigma+ states in lifetime_data directory
grep A2Sigma+ /home/standjung/"$input"_"$i"_j_"$jval".life > /home/standjung/masterscript/exocross_out/lifetime_data/"$input"_"$i"_j_"$jval".dat
#Saving the .life and .out files to exocross_inp
find /home/standjung/masterscript/ -name '*.life' -exec mv {} /home/standjung/masterscript/exocross_out/ \;
find /home/standjung/masterscript/ -name '*_lifetime.out' -exec mv {} /home/standjung/masterscript/exocross_out/ \;
#Saving the .trans and .states files to exocross_inp, the .out files to duo_out
find /home/standjung/ -name '*.out' -exec mv {} /home/standjung/masterscript/duo_out/ \;
find /home/standjung/ -name '*.states' -exec mv {} /home/standjung/masterscript/exocross_inp/ \;
find /home/standjung/ -name '*.trans' -exec mv {} /home/standjung/masterscript/exocross_inp/ \;
done



