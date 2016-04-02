#============================================
# Get data
args <- commandArgs(TRUE);
dir <- args[2]
data <- read.csv(paste0(dir,"tmp/data.csv"));

#============================================
# Get a timing
months_length <- c(31,29,31,30,31,30,31,31,30,31,30,31);
first_element <- data[1,];

time <- ((12+data$mon-first_element$mon)%%12)*months_length[first_element$mon]  + (data$day-first_element$day) + (data$h) / (24.0)  + (data$m) / (24.0*60.0);

data$timestamp <- time;

max_time = floor(max(data$timestamp))+1;
time_bins <- c(0:(max_time*24))/24;

#============================================

