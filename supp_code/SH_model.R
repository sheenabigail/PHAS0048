# Find the filenames corresponding to a given J,e/f, and +/-.
# I generated them using the bash command:
# for i in `ls *.states`; do grep "      1.5 + f " $i >$i.2 ; done
setwd("D:/STUDY/UCL/PHAS0048/energyvsbox/rfiles_v2_200points_01reor/")  
files=list.files(path="D:/STUDY/UCL/PHAS0048/energyvsbox/rfiles_v2_200points_01reor/",pattern = "*.states.2")
#Read the last file for getting the number of rows.
# tmp=read.table(files[max(length(files))])
tmp=read.table(file = "SH_MRCI_02_L6.480_J10_95ma_v2.states.2")
# print(tmp)
max.dim=length(tmp$V2)
print(max.dim)
# Create the matrix and initialize the values with NA (NaN in any other
# language, but R wants to feel different)
m=matrix(NA,ncol = 200,nrow = max.dim)
# step is the increase in the box size.
step=0.02
# Read the state files and store energies in matrix
for (i in seq(1,200,by=1)){ # loop over all the files 
  box=2.500+(i-1)*0.01 # calculate the box size 
  data=read.table(files[i]) # read the state file
  print(dim(data))
  m[1:length(data$V2),i]=data$V2 # store the info inside the matrix
}
# Save the transpose matrix of m 
mt=t(m)
mt=na.omit(mt)
# Store r_box 
r=seq(2.500,6.480,by=0.02)
# Export the E vs r_box  for each single state.
for (i in seq(1,max.dim,1)){
  outname=paste(i,".dat",sep="")
  filer=na.omit(cbind(r,m[i,]))
  write.table(file =outname,filer,col.names = F,row.names = F)
}
