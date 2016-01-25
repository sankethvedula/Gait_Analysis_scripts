smoothen_data <- function(kinectData)
{
	# smoothening is feasible because for a normal person won't change 10 degrees 	

}

plot_all_data <- function(kinectData,viconData_sample1,viconData_sample2,kinectData_sample4)
{
	avg_kinect_angle = kinectData+viconData_sample2+viconData_sample1+kinectData_sample4
	avg_kinect_angle = avg_kinect_angle/4
	plot(kinectData,type="l",xlab="% of gait cycle",ylab="Left Knee Flexion Angle",col="blue")
	lines(viconData_sample2,col="blue")
	lines(viconData_sample1,col="blue")
	lines(kinectData_sample4,col="blue")
	lines(avg_kinect_angle,col="red")


}

calculate_even_lower <- function(temp_frac)
{
	temp_int = as.integer(temp_frac)
	if(temp_int%%2 == 0)
	{
		return(temp_int)
	}else{
		return(temp_int - 1)
	}
}

calculate_errors <- function(kinectData,trans_vicon)
{
 trans_vicon <- as.data.frame(trans_vicon)
 trans_vicon <- trans_vicon[,1]
  if(length(kinectData) > length(trans_vicon))
  {
    error1 = trans_vicon[,2] - kinectData[1:(length(trans_vicon))]
  }else{
  error1 = trans_vicon[1:length(kinectData)] - kinectData 
  }
  #-----------sMAPE---------------
    MdAPE = 0
  list_MdAPE <- NULL  
for(k in 1:length(error1))
  {
    if(trans_vicon[k] != 0)
    {
	  numerator = abs(error1[k])
	  denominator = abs(error1[k]+trans_vicon[k])	
      temp_err <- numerator/denominator
      #temp_err <- (abs(error1[k])/(trans_vicon[k,2]))
      list_MdAPE <- c(list_MdAPE,temp_err)
    }else{
    temp_err <-  abs(error1[k])/abs(error1[k])
    list_MdAPE <- c(list_MdAPE)   
    }
  }
  #list_MdAPE <- remove_outliers_errors(list_MdAPE)
  print("Successful")
  MdAPE <- mean(list_MdAPE)
  return(MdAPE)
}

totalData = read.csv("C:\\Users\\SaiSakanki\\Desktop\\Gait\\Analyse data\\temp.csv",sep=",")
viconData = read.csv("C:\\Users\\SaiSakanki\\Desktop\\Gait\\Analyse data\\vicon.csv",sep=",")
kinectData = totalData[,5]

percent_value = NULL

for(i in 1:length(kinectData))
{
	percent_value = c(percent_value,(i/length(kinectData))*100)

}
percent_plus_kinect = cbind(percent_value,kinectData)

temp_vicon = viconData[,1]
temp_vicon = c(5.84,temp_vicon)
gen_seq = seq(2,100,by=2)
temp_vicon = cbind(gen_seq,temp_vicon)

trans_vicon <- NULL
for(index in 1:length(percent_value))
{
	temp_frac = percent_value[index]
	nearest_lower_even = calculate_even_lower(temp_frac)
	nearest_upper_even = nearest_lower_even + 2
	lower_weight = temp_frac - nearest_lower_even
	upper_weight = nearest_upper_even - temp_frac
	found_index = which(temp_vicon[,1] == nearest_lower_even)
	if(index == length(percent_value)){
		transformed_value = temp_vicon[found_index,2]
	}else{
		transformed_value = temp_vicon[found_index,2]*lower_weight + temp_vicon[found_index+1,2]*upper_weight
	}
	transformed_value = transformed_value/(lower_weight+upper_weight)
	trans_vicon <- c(trans_vicon,transformed_value)
}

# viconData_sample1 = totalData[,2]
# viconData_sample2 = totalData[,3]
# kinectData_sample1 = totalData[,4]
# kinectData_sample2 = totalData[,5]
# kinectData_sample3 = totalData[,6]
# kinectData_sample4 = totalData[,7]
# kinectData_sample1 = na.omit(kinectData_sample1)
# kinectData_sample2 = na.omit(kinectData_sample2)
# kinectData_sample3 = na.omit(kinectData_sample3)
# kinectData_sample4 = na.omit(kinectData_sample4)
# avg_kinect_angle = kinectData_sample4+kinectData_sample2+kinectData_sample3+kinectData_sample1
# avg_kinect_angle = avg_kinect_angle/4
#kinectData = na.omit(kinectData)
temp = viconData_sample1[15:50]
plot(temp,type="l")
lines(avg_kinect_angle)

length_data = length(kinectData)
viconData_sample2 = viconData_sample2[1:length_data]
viconData_sample1 = viconData_sample1[1:length_data]
plot_all_data(kinectData_sample3,kinectData_sample2,kinectData_sample1,kinectData_sample4)
# smoothen data 

