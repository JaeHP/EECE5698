#/usr/bin/env bash

#Identify port number for GPS Device
ls /dev/ttyUSB*
echo 'Now Plug in the GPS Device, the press Enter:'
read USB_number
ls /dev/ttyUSB*

#Getting GPS Device port number
echo 'Input the USB number of GPS device from the list above:'
read USB_number
sudo chmod 666 /dev/ttyUSB$USB_number

#Publish GPSdata
python ./examples/python/gpsdriver.py $USB_number &

#Log the GPSdata topic messages
lcm-logger -i -c "GPSData" ./log_files/GPSlog &

#Set and run lcm-spy
export CLASSPATH=$PWD/examples/lcm-spy/my_types.jar
lcm-spy

#Kill background Processes
kill %1 %2

#Plot GPSlog data
export log_files=$(ls ./log_files/GPS*)
python ./examples/python/gpsplot.py $log_files 
 



