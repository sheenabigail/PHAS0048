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
sed -e "s/@rend/"$i"/g; s/@jval/"$jval"/g" "$input".inp> /path/to/directory/containing/duo/input/files/"$input"_"$i"_j_"$jval".inp 
#Running duo, saving the .out files to duo_out
/file/path/for/duo/exec/file </path/to/directory/containing/duo/input/files/"$input"_"$i"_j_"$jval".inp>/path/to/directory/containing/duo/output/files/"$input"_"$i"_j_"$jval".out
#Creating modified exocross lifetime input files, saving them to exocross_inp
sed -e "s/@rend/"$i"/g; s/@out/"$input"/g; s/@jval/"$jval"/g" /file/path/for/modifiable/exocross/input/file > /path/to/directory/containing/exocross/input/files/"$input"_"$i"_j_"$jval"_lifetime.inp
#Running exocross, saving the .out files to exocross_out
/file/path/for/exocross/exec/file </path/to/directory/containing/exocross/input/files/"$input"_"$i"_j_"$jval"_lifetime.inp>/path/to/directory/containing/exocross/output/files/"$input"_"$i"_j_"$jval"_lifetime.out
#Saving lifetimes for A2Sigma+ states in lifetime_data directory
grep A2Sigma+ /directory/containing/.life/files/"$input"_"$i"_j_"$jval".life > /path/to/directory/containing/reduced/exocross/output/files/"$input"_"$i"_j_"$jval".dat
#Saving the .life and .out files to exocross_inp
find /path/to/directory/containing/exocross/output/files/ -name '*.life' -exec mv {} /path/to/directory/storing/exocross/output/files/ \;
find /path/to/directory/containing/exocross/output/files/ -name '*_lifetime.out' -exec mv {} /path/to/directory/storing/exocross/output/files/ \;
#Saving the .trans and .states files to exocross_inp, the .out files to duo_out
find /path/to/directory/containing/duo/output/files/ -name '*.out' -exec mv {} /path/to/directory/storing/duo/output/files/ \;
find /path/to/directory/containing/exocross/output/files/ -name '*.states' -exec mv {} /path/to/directory/storing/exocross/input/files/ \;
find /path/to/directory/containing/exocross/output/files/ -name '*.trans' -exec mv {} /path/to/directory/storing/exocross/input/files/ \;
done



