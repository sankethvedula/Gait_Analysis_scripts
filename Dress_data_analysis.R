fileNames = list.files("C:\\Users\\SaiSakanki\\Desktop\\Gait\\Dress_data 3rd Feb\\Full Data",pattern=".csv",full.names = TRUE)
for (file1 in 1:length(fileNames))
{
	MAD_write_list <- NULL
	print(paste("Entering the file ",fileNames[file1]))

	data = read.csv(fileNames[file1])

	sample1 = data[,1]
	sample2 = data[,2]
	sample3 = data[,3]
	sample4 = data[,4]
	sample5 = data[,5]
    sample_mean = data[,6]
	sample_length = length(data[,1])

	MAD_Sample1_list = (sample1-sample_mean)^2
	MAD_Sample2_list = (sample2-sample_mean)^2
	MAD_Sample3_list = (sample3-sample_mean)^2
	MAD_Sample4_list = (sample4-sample_mean)^2
	MAD_Sample5_list = (sample5-sample_mean)^2


	MAD_write_list <- c(mean(MAD_Sample1_list),mean(MAD_Sample2_list),mean(MAD_Sample3_list),mean(MAD_Sample4_list),mean(MAD_Sample5_list))
	MAD_write_list <- sqrt(MAD_write_list)
	write_folder = "C:\\Users\\SaiSakanki\\Desktop\\Gait\\Dress_data 3rd Feb\\Full Data\\results\\"
	write_file_name = paste(write_folder,"results ",file1,".csv",sep="")
	write.table(MAD_write_list,write_file_name,append=FALSE,sep=",",col.names=FALSE,row.names=FALSE)
}
