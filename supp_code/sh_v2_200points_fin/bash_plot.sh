for i in `ls *.states`; 
do grep "1.5 + f" $i >$i.2 ; 
done
