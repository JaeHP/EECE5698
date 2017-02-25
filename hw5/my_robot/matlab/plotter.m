clear
close all
% Set java class path
javaaddpath('./../java/lcm.jar')
javaaddpath('./../java/my_types.jar')

% Get the user input for file name to be read
log_list = evalc('ls ./../log_files');
log_list = split(log_list);
log_list = log_list(1:end-1)
index = input('Enter the index(starts at #1) of the log file to plot:');

% Set log file handler
log_file = lcm.logging.Log(char('./../log_files/' + log_list(index)),'r');

% Store handlers for all log events in a cell array structure and get the 
% number of points for each channel
gpspoints=0;
imupoints=0;
ev={};

while true
    try
        ev(end+1)=log_file.readNext();
        
        if strcmp(ev{end}.channel,'GPSData')
                gpspoints = gpspoints+1;
        elseif strcmp(ev{end}.channel,'IMUData')
                imupoints = imupoints+1;
        end
    catch %ME
%         if  contains(ME.message, 'java.io.EOFException')
%             disp('EOF detected')
            break;
%         else
%             disp(ME.message)
%             continue;
%         end        
    end
end

%Store data in appropriate variables
gpstimestamp=zeros(1,gpspoints);utm=zeros(2,gpspoints);%alt=zeros(gpspoints);
imutimestamp=zeros(1,imupoints); ypr=zeros(3,imupoints);
mag=zeros(3,imupoints);
accel=zeros(3,imupoints);
gyro=zeros(3,imupoints);
utime=ev{1}.utime;
gi=0;
ii=0;

for x = 1:(gpspoints+imupoints)
    if strcmp(ev{x}.channel,'GPSData')
        gi = gi+1;
        temp = sensors.gps_t(ev{x}.data);
        gpstimestamp(gi) = ev{x}.utime - utime;
        utm(1,gi) = temp.utm_x;
        utm(2,gi) = temp.utm_y;
    end
        
    if strcmp(ev{x}.channel,'IMUData')
        ii = ii + 1;
        imutimestamp(ii) = ev{x}.utime - utime;
        temp = sensors.imu_t(ev{x}.data);
        ypr(1,ii) = temp.yaw;
        ypr(2,ii) = temp.pitch;
        ypr(3,ii) = temp.roll;
        mag(1,ii) = temp.mag_x;
        mag(2,ii) = temp.mag_y;
        mag(3,ii) = temp.mag_z;
        accel(1,ii) = temp.accel_x;
        accel(2,ii) = temp.accel_y;
        accel(3,ii) = temp.accel_z;
        gyro(1,ii) = temp.gyro_x;
        gyro(2,ii) = temp.gyro_y;
        gyro(3,ii) = temp.gyro_z;
    end
end

%Adjust time units to seconds
gpstimestamp = gpstimestamp/1e+06;
imutimestamp = imutimestamp/1e+06;
%% 

%Process GPS data to plot
utm = medfilt1(utm,3,[],2);
if gpspoints
    utm = utm - utm(:,1);
end
%Process Magnetometer data
%Filter outliers
mag = medfilt1(mag,3,[],2);

%Hard-iron/Soft-iron calibration
ii = input('Do you have a calibration log file:[y/n]','s');
if ii == 'y' || ii == 'Y' 
    cal = magcalib();
    mag_cal = cal(:,1:2)*(mag(1:2,:)-repmat(cal(:,3),1,length(mag)));
else 
    mag_cal=mag;
end
%%
%Yaw angle measurements
%From magnetometer
yawmag = atan2(mag_cal(2,:),mag_cal(1,:));
yawoffset = mean(yawmag(1:10));
%From gyroscope(integrate data)
%using cumtrapz
yawg_ctz =- cumtrapz(imutimestamp,gyro(3,:));
% yawg_ctz = -yawg_ctz - yawoffset;


%usinf 1-pole butterworth lowpass filter
% yawg_blf

%Combined Results (yawmag+yawg)(Use complementary filter)
%Also compensate for yaw offset and transform to 
%true cartesian(X-axis on the right and Y-axis in 
% the front) frame from imu device frame
bestyaw = wrapToPi((0.98*yawg_ctz + 0.02*yawmag)+(pi/2)-yawoffset);

%%

%Accelerometer data processing
%X-Velocity and X-displacement (integrate accelx data)
accel = accel - mean(accel,2);
x_vel = cumtrapz(imutimestamp,accel(1,:));
x_disp = cumtrapz(imutimestamp,x_vel);

%Compute estimated Y-accel (X-velocity*yaw_rate)
accely_est = x_vel .* gyro(3,:);




%Get true trajectory
%Get step displacements and convert polar co-ordinate measurements to
%cartesian co-ordinate system
x_disp_d=[0,diff(x_disp)];
[x,y]=pol2cart(bestyaw,x_disp_d);

%Get cumulative(absolute) sum of data and offset it to first gps points
cumx = cumsum(x)*1.1/3; 
cumy = cumsum(y)*1.1/3;
%%

%Plots
%Yaw angle plots without compensating for co-ordinate frames and offset
close all
figure();
hold on
plot(imutimestamp,yawmag*180/pi);       %Magnetometer yaw angle plot
yawg_ctzp=wrapTo180(yawg_ctz*180/pi);   %Integrated Gyroz yaw angle plot
plot(imutimestamp,yawg_ctzp);           
plot(imutimestamp,wrapTo180(radtodeg(bestyaw+yawoffset)-90));      %complemetart filter results
%Compare with ypr data (convert ypr  into radians first)
plot(imutimestamp,wrapTo180(-ypr(1,:)));
title('Comparision of Yaw angles')
legend('Magnetometer data','Gyro data','Filtered data','IMU data');
hold off
%Compare with accely data
figure();
hold on
plot(imutimestamp,accel(2,:));
plot(imutimestamp,accely_est);
legend('AccelY Data','Estimated AccelY');
hold off;
%Compare IMUdata with GPSdata
figure();
scatter(cumx,cumy);
hold on;
scatter(utm(1,:),utm(2,:));
title('GPS vs IMU Plot')
legend('IMU data','GPS data');