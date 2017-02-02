hw3 Directory structure:
plots/                  #Directory for all plot images
extras/                 #Directory for presentation and reading_assignment files    
lcm/                    #Directory for all codes and log files
    botsetup.bash       #bash file to receive, log, and plot GPSData
    plot_logfiles.bash  #bash file to plot log files 
    log_files/          #Directory for all log files
    examples/           #Directory for all code files
        types/          #Directory for message types
        lcm-spy/        #Directory for files needed for lcm-spy
        python/         #Directory for python codes + gen-types and clean-up files  

Steps to follow:

NOTE: 
Do not plugin GPS Device yet. You will be prompted to do so. (This will help in identifying GPS device port number)        
        

IMPORTANT STEP: 
Change present working directory to lcm/ using 'cd lcm' command in terminal. Then, run the bash file using './botsetup.bash' command.
 

IMPORTANT INFO: 
Close lcm-spy window only when done collecting data from GPS device.

INFO:
Log files are named sequentially as GPSlog.00, GPSlog.01,...
GPSPlot.py script will prompt user to input number of log files to process for plotting. For example, if user enters 2 as input, script will plot two most recent log files.

STEP: 
Close all plot windows, AFTER saving them, to exit python and bash scripts   

ADDITIONAL INFO:
Use plot_logfiles.bash to plot any log files in the log folder. OR edit plot_logfiles.bash to run error_estimation.py instead of gpsplot.py in order to obtain accuracy measures such as CEP and 2DRMS with their plots.
