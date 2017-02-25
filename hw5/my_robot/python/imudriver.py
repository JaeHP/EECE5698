#!/usr/bin/env python

import sys
import lcm
import time
import serial
import sensors
import utm

class IMU(object):

## Class initialization    
    def __init__(self,port_name):
        self.port = serial.Serial(port_name,115200)
        self.lc = lcm.LCM("udpm://?ttl=12")
        self.data = sensors.imu_t()
        print 'Init  complete'

## IMU Data Publish function        
    def readloop(self):
        while True:
            try:
                line = self.port.readline()
           
                if not line.startswith('$VNYMR'):
                    continue
                vals = [x for x in line.split(',')]
                
                if any(len(x) == 0 for x in vals):
                    continue    
                self.data.yaw=float(vals[1])
                self.data.pitch=float(vals[2])
                self.data.roll=float(vals[3])
                self.data.mag_x=float(vals[4])
                self.data.mag_y=float(vals[5])
                self.data.mag_z=float(vals[6])
                self.data.accel_x=float(vals[7])
                self.data.accel_y=float(vals[8])
                self.data.accel_z=float(vals[9])
                self.data.gyro_x=float(vals[10])
                self.data.gyro_y=float(vals[11])
                self.data.gyro_z=float(vals[12].split('*')[0])
                self.lc.publish("IMUData",self.data.encode())
            
            except:
                print 'IMU ERROR ('+ line +')'

if __name__ == "__main__":
    if len(sys.argv) > 1:
        port_name = '/dev/ttyUSB'+sys.argv[1]
        print 'given port name' + port_name+'\n\n\n'
        myimu=IMU(port_name)
        
    else:
        print 'no port number provided\n\n\n\n'
        sys.exit(0)
    myimu.readloop()

