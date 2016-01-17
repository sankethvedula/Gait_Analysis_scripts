CONST_NO_OF_SAMPLES = 10
COSNT_NO_OF_DRESS_CODES = 5

folder = "C:\\Users\\SaiSakanki\\Desktop\\Gait\\Analysis Scripts\\Samples\\"

for(fold in 1:CONST_NO_OF_SAMPLES){
	sub_fold = paste("Sample_person_",fold,sep="")
	dir.create(file.path(folder,sub_fold),showWarnings=FALSE)
	for(dc in 1:COSNT_NO_OF_DRESS_CODES)
	{	
		currentLocation = paste(folder,sub_fold,"\\",sep="")
		current_sub_folder = paste("Dress_code_",dc,sep="")
		#print(current_sub_folder)
		dir.create(file.path(currentLocation,current_sub_folder),showWarnings = FALSE)
		
	}
}
