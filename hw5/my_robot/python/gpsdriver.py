#!/usr/bin/env python

import sys
import lcm
import time
import serial
import sensors
import utm

class GPS(object):

## Class initialization    
    def __init__(self,port_name):
        self.port = serial.Serial(port_name,4800)
        self.lc = lcm.LCM()
        self.data = sensors.gps_t()
        print 'Init  complete'

## GPS Data Publish function        
    def readloop(self):
        while True:
            try:
                line = self.port.readline()
                if line.startswith('$GPGGA'):
                    continue
                vals = [x for x in line.split(',')]
                if any(len(x) == 0 for x in [vals[2],vals[4],vals[9]]):     ## Check if data is available
                    continue
                self.data.timestamp = vals[1]
 
                lat_sign = (-1 * (vals[3] == 'S')) + (vals[3] == 'N')
                lon_sign = (-1 * (vals[5] == 'W')) + (vals[5] == 'E')
                self.data.lat = (int(vals[2][:2]) + float(vals[2][2:])/60) * lat_sign  #convert degree minutes format to decimal degrees
                self.data.lon = (int(vals[4][:3]) + float(vals[4][3:])/60) * lon_sign
                self.data.alt = float(vals[9])
                utm_data = utm.from_latlon(self.data.lat,self.data.lon)
                self.data.utm_x = utm_data[0];
                self.data.utm_y = utm_data[1];
                self.lc.publish("GPSData",self.data.encode())
            except:
                print 'GPS ERROR ('+ line +')'

if __name__ == "__main__":
    if len(sys.argv) > 1:
        port_name = '/dev/ttyUSB'+sys.argv[1]
        print 'given port name' + port_name+'\n\n\n'
        mygps=GPS(port_name)
        
    else:
        print 'no port number provided\n\n\n\n'
        sys.exit(0)
    mygps.readloop()

