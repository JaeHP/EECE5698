import lcm
import sys
import matplotlib.pyplot as plt
from bot_messages import gpsdata

#Check and assign arguments
if len(sys.argv) < 2:
    sys.stderr.write("usage: python gpsplot <logfile>\n")
    sys.exit(1)

log_file = sys.argv[1:len(sys.argv)]
log_file.reverse()    #Make most recent one as first element
print log_file 

#How many log_files to print user input
number = input('\nInput a list of indexes of the log files (shown above) to plot "as [#,#,#]":')

#Create array of co-ords from messages
for x in number:
    log = lcm.EventLog(log_file[x], "r")
    utmx=[]
    utmy=[]
    for event in log:
##Uncomment if logger logged other channels
#        if event.channel == "GPSData": 
            msg = gpsdata.decode(event.data)
            utmx.append(msg.utm_x)
            utmy.append(msg.utm_y)
    
#    print utmx
#    print utmy
#Plot in different windows
    plt.figure()
    plt.xlabel('UTM X')
    plt.ylabel('UTM Y')
    plt.axis([min(utmx)-2,max(utmx)+2,min(utmy)-2,max(utmy)+2])
    plt.plot(utmx,utmy,'ro')
    
#Show plots and then close them    
plt.show()
plt.close('all')
