import lcm
import sys
import matplotlib.pyplot as plt
from bot_messages import gpsdata
import numpy

#Check and assign arguments
if len(sys.argv) < 2:
    sys.stderr.write("usage: python gpsplot <logfile>\n")
    sys.exit(1)

log_file = sys.argv[1:len(sys.argv)]
log_file.reverse()    #Make most recent one as first element
print log_file 

#Which log_files to print user input
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
#    xtrue=327242
#    ytrue=4688999
#Statistics Calculations
    xmean=numpy.mean(utmx)
    ymean=numpy.mean(utmy)
    xstd=numpy.sqrt(sum(numpy.square(utmx-(numpy.ones(len(utmx))*xmean)))/len(utmx))
    ystd=numpy.sqrt(sum(numpy.square(utmy-(numpy.ones(len(utmy))*ymean)))/len(utmy))
    cep=0.59*(xstd+ystd)
    twodrms=2*numpy.sqrt(xstd*xstd+ystd*ystd)
    print 'xmean = ' + str(xmean) + ' meters\nymean = ' + str(ymean) +' meters' 
    print 'xstd deviation = ' + str(xstd) + '\nystd deviation =' + str(ystd)
    print 'cep = ' + str(cep) + ' meters'
    print '2drms = ' + str(twodrms) + ' meters' 

#Plot in different windows   
    plt.figure()
    plt.xlabel('UTM X')
    plt.ylabel('UTM Y')
    plt.axis([min(utmx)-4,max(utmx)+4,min(utmy)-4,max(utmy)+4])
    plt.plot(utmx,utmy,'ro')
    circle1 = plt.Circle((xmean,ymean), cep , color = 'g',fill = False)
    circle2 = plt.Circle((xmean,ymean), twodrms, color = 'b', fill = False)
    plt.gcf().gca().add_artist(circle1)
    plt.gcf().gca().add_artist(circle2)
#Show plots and then close them    
plt.show()
plt.close('all')
