#============================================
# Get data
args <- commandArgs(TRUE);
dir <- args[2]
data <- read.csv(paste0(dir,"tmp/data.csv"),row.names=NULL);

#============================================
# Get a timing
months_length <- c(31,29,31,30,31,30,31,31,30,31,30,31);
first_element <- data[1,];

time <- ((12+data$mon-first_element$mon)%%12)*months_length[first_element$mon]  + (data$day-first_element$day) + (data$hour) / (24.0)  + (data$min) / (24.0*60.0);

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
    act_file <- paste(dir,"out/",name,"_hist.png",sep="");
    png(filename=act_file, width=860);
    hist(df$timestamp, breaks=time_bins, xlim=c(0,max_time), xlab="Time [days]", col=color, main="");
    dev.off(); 

    # Print IPs histogram
    ip_file <- paste(dir,"out/",name,"_ips.png",sep="");
    png(filename=ip_file, width=860);
    barplot(sort(table(as.character(df$ip)), decreasing=TRUE), col=color, xaxt='n');
    dev.off();

    # Print top 5
    par(cex.axis=0.8);
    topip_file <- paste(dir,"out/",name,"_ips_top.png",sep="");
    png(filename=topip_file, width=640);
    barplot(sort(table(as.character(df$ip)), decreasing=TRUE)[1:5], col=color);
    dev.off();
    par(cex.axis=1);

    topreq_file <- paste(dir,"out/",name,"_reqs_top.png",sep="");
    png(filename=topreq_file, width=640);
    barplot(sort(table(as.character(df$req)), decreasing=TRUE)[1:5], col=color);
    dev.off();
  }
}

#============================================
plot_df(data,"all");

#============================================
data_200 <- data[data$status==200,]
plot_df(data_200,"received");


