#============================================
# Get data
data = read.csv("tmp/data.csv");

#============================================
# Get a timing
months_length <- c(31,29,31,30,31,30,31,31,30,31,30,31);
first_element <- data[1,];

time <- ((12+data$mon-first_element$mon)%%12)*months_length[first_element$mon]  + (data$day-first_element$day) + (data$h) / (24.0)  + (data$m) / (24.0*60.0);
#time <- (data$mon-first_element$mon)*months_length[first_element$mon]  + (data$day-first_element$day) + (data$h-first_element$h) / (24.0)  + (data$m-first_element$m) / (24.0*60.0);

#str(time)
data$timestamp <- time;

#str(data)
max_time = floor(max(data$timestamp))+1;
time_bins <- c(0:(max_time*24))/24;

#============================================
# Function to plot the different parts
plot_df = function(df,name,color="blue") 
{
  # Print activity
  act_file <- paste("out/",name,"_hist.png",sep="")
  png(filename=act_file, width=860);
  hist(df$timestamp, breaks=time_bins, xlim=c(0,max_time), xlab="Time [days]", col=color, main="");
  dev.off(); 

  # Print IPs histogram
  ip_file <- paste("out/",name,"_ips.png",sep="")
  png(filename=ip_file, width=860);
  barplot(sort(table(as.character(df$ip)), decreasing=TRUE), col=color, xaxt='n');
  dev.off();

  # Print top 5
  par(cex.axis=0.8)
  topip_file <- paste("out/",name,"_ips_top.png",sep="")
  png(filename=topip_file, width=640);
  barplot(sort(table(as.character(df$ip)), decreasing=TRUE)[1:5], col=color);
  dev.off();
  par(cex.axis=1)
}

#============================================
# Analyse succesful logings
data_success <- data[data$type == 7,]
#png(filename="out/accepted_hist.png", width=860);
#hist(data_success$timestamp, breaks=time_bins, xlim=c(0,max_time), xlab="Time [days]", col="red", main="");
#dev.off(); 
#
#png(filename="out/accepted_ips.png",width=640);
#barplot(table(as.character(data_success$ip)), col="red");
#dev.off();
plot_df(data_success,"accepted","red")


#============================================
# General activity not accepted
data_denied <- data[data$type != 7,]

plot_df(data_denied,"denied")

## Print activity
#png(filename="out/denied_hist.png", width=860);
#hist(data_denied$timestamp, breaks=time_bins, xlim=c(0,max_time), xlab="Time [days]", col="blue", main="");
#dev.off(); 
#
## Print IPs histogram
#png(filename="out/all_ips_denied.png", width=860);
#barplot(sort(table(as.character(data_denied$ip)), decreasing=TRUE), col="blue", xaxt='n');
#dev.off();
#
## Print top 5
#par(cex.axis=0.8)
#png(filename="out/top_ips_denied.png", width=640);
#barplot(sort(table(as.character(data_denied$ip)), decreasing=TRUE)[1:5], col="blue");
#dev.off();
#par(cex.axis=1)

# histograms time but selecting grounds 1 to 6
# list successful log in
# list the 10 most persistent IPs
# list all the attempted usernames
