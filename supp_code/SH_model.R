# Find the filenames corresponding to a given J,e/f, and +/-.
# I generated them using the bash command:
# for i in `ls *.states`; do grep "      1.5 + f " $i >$i.2 ; done
setwd("directory/path/containing/.states.2/files")  
files=list.files(path="directory/path/containing/.states.2/files",pattern = "*.states.2")
#Read the last file for getting the number of rows.
tmp=read.table(files[max(length(files))])
max.dim=length(tmp$V2)
# Create the matrix and initialize the values with NA (NaN in any other
# language, but R wants to feel different)
m=matrix(NA,ncol = "number of states files",nrow = max.dim)
# step is the increase in the box size.
step="value of dl used in do-submit-duo-loop.sh"
# Read the state files and store energies in matrix
for (i in seq(1,"number of states files",by=1)){ # loop over all the files 
  box="value of L used in do-submit-duo-loop.sh"+(i-1)*"value of dl used in do-submit-duo-loop.sh" # calculate the box size 
  data=read.table(files[i]) # read the state file
  print(dim(data))
  m[1:length(data$V2),i]=data$V2 # store the info inside the matrix
}
# Save the transpose matrix of m 
mt=t(m)
mt=na.omit(mt)
# Store r_box 
r=seq("value of L used in do-submit-duo-loop.sh","max box size in do-submit-duo-loop.sh",by="value of dl used in do-submit-duo-loop.sh")
# Export the E vs r_box  for each single state.
for (i in seq(1,max.dim,1)){
  outname=paste(i,".dat",sep="")
  filer=na.omit(cbind(r,m[i,]))
  write.table(file =outname,filer,col.names = F,row.names = F)
}
