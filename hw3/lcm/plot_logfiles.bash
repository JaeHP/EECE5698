#/usr/bin/env bash
#Plot log files
export log_files=$(ls ./log_files/GPS*)
python ./examples/python/gpsplot.py $log_files
