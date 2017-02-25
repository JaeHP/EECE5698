#/usr/bin/env bash

#Identify port number for GPS Device
#ls /dev/ttyUSB*
#echo 'Now Plug in the GPS Device, then press Enter:'
#read GPS_number
#ls /dev/ttyUSB*

#Getting GPS Device port number
#echo 'Input the USB number of GPS device from the list above:'
#read GPS_number
#sudo chmod 666 /dev/ttyUSB$GPS_number



#Identify port number for IMU Device
ls /dev/ttyUSB*
echo 'Now Plug in the IMU Device, then press Enter:'
read IMU_number
ls /dev/ttyUSB*

#Getting IMU Device port number
echo 'Input the USB number of IMU device from the list above:'
read IMU_number
sudo chmod 666 /dev/ttyUSB$IMU_number



#Publish GPSdata
#python ./python/gpsdriver.py $GPS_number &

#Publish IMUdata
python ./python/imudriver.py $IMU_number &

#Log the GPSdata topic messages
lcm-logger -s ./log_files/lcm-log-%F-%T &

#Set and run lcm-spy
export CLASSPATH=$PWD/java/my_types.jar
lcm-spy

#Kill background Processes
kill %1 %2 #%3




