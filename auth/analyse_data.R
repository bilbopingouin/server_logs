#============================================
# Get data
args <- commandArgs(TRUE);
#str(args)
#data = read.csv("tmp/data.csv");
#cat("filename: ",args[2])
dir <- args[2]
data <- read.csv(paste0(dir,"tmp/data.csv"));
#str(data)

#============================================
# Get a timing
months_length <- c(31,29,31,30,31,30,31,31,30,31,30,31);
first_element <- data[1,];

time <- ((12+data$mon-first_element$mon)%%12)*months_length[first_element$mon]  + (data$day-first_element$day) + (data$h) / (24.0)  + (data$m) / (24.0*60.0);

data$timestamp <- time;

max_time = floor(max(data$timestamp))+1;
time_bins <- c(0:(max_time*24))/24;

#============================================
# Function to plot the different parts
plot_df = function(df,name,color="blue") 
{
  if (length(df$ip)>1)
  {

    # Print activity
    act_file <- paste(dir,"out/",name,"_hist.png",sep="")
    png(filename=act_file, width=860);
    hist(df$timestamp, breaks=time_bins, xlim=c(0,max_time), xlab="Time [days]", col=color, main="");
    dev.off(); 

    # Print IPs histogram
    ip_file <- paste(dir,"out/",name,"_ips.png",sep="")
    png(filename=ip_file, width=860);
    barplot(sort(table(as.character(df$ip)), decreasing=TRUE), col=color, xaxt='n');
    dev.off();

    # Print top 5
    par(cex.axis=0.8)
    topip_file <- paste(dir,"out/",name,"_ips_top.png",sep="")
    png(filename=topip_file, width=640);
    barplot(sort(table(as.character(df$ip)), decreasing=TRUE)[1:5], col=color);
    dev.off();
    par(cex.axis=1)
  }
}

plot_usernames = function(df,name,color="blue")
{
  if (length(df$var) > 0)
  {
    # Print usernames histogram
    ip_file <- paste(dir,"out/",name,"_usr.png",sep="")
    png(filename=ip_file, width=860);
    barplot(sort(table(as.character(df$var)), decreasing=TRUE), col=color, xaxt='n');
    dev.off();

    # Print top 5
    par(cex.axis=0.8)
    topip_file <- paste(dir,"out/",name,"_usr_top.png",sep="")
    png(filename=topip_file, width=640);
    barplot(sort(table(as.character(df$var)), decreasing=TRUE)[1:5], col=color);
    dev.off();
    par(cex.axis=1)
  }
}

#============================================
# Analyse succesful logings
data_success <- data[data$type == 7,]
plot_df(data_success,"accepted","red")


#============================================
# General activity not accepted
data_denied <- data[data$type != 7,]
plot_df(data_denied,"denied")

#============================================
# Analyse of invalid logings
data_invalid <- data[data$type == 1,]
plot_df(data_invalid,"invalid","#ff8c00")
plot_usernames(data_invalid,"invalid","#ff8c00")

#============================================
# Analyse of failed logings
data_failed <- data[data$type == 2,]
plot_df(data_failed,"failed","#ff8c00")
plot_usernames(data_failed,"failed","#cc00f8")

#============================================
# Analyse of no_id_string logings
data_no_id_string <- data[data$type == 3,]
plot_df(data_no_id_string,"no_id_string","#00b135")

#============================================
# Analyse of root_refused logings
data_root_refused <- data[data$type == 4,]
plot_df(data_root_refused,"root_refused","#b16c00")

#============================================
# Analyse of break_in logings
data_break_in <- data[data$type == 5,]
plot_df(data_break_in,"break_in","#02deff")

#============================================
# Analyse of disconnect logings
data_disconnect <- data[data$type == 6,]
plot_df(data_disconnect,"disconnect","#f0ff02")

#============================================
# Usernames
usernames <-sort(table(as.character(data[data$var != 0,]$var)),decreasing=TRUE)
write.csv(usernames,file=paste0(dir,"tmp/usernames.txt"))

