function cal = magcalib()
% Get the user input for file name to be read
% disp()
javaaddpath('./../java/lcm.jar');
javaaddpath('./../java/my_types.jar');
log_list = evalc('ls ./../log_files');
log_list = split(log_list);
log_list = log_list(1:end-1)
index = input('Enter the index(starts at #1)of the log file to use for calibration:');

% Set log file handler
log_file = lcm.logging.Log(char('./../log_files/' + log_list(index)),'r');

% Store magnitude data
mag=[];
while true
    try
        ev = log_file.readNext();
        if strcmp(ev.channel,'IMUData')
            temp = sensors.imu_t(ev.data);
            mag(1,end+1) = temp.mag_x;
            mag(2,end) = temp.mag_y;
%             mag(3,end+1) = temp.mag_z;
        end
    catch
        break;
    end
end
figure();
scatter(mag(1,:),mag(2,:));
title('Uncalibrated Magnetometer readings');

%Fit data and get ellipse parameters
e = fit_ellipse(mag(1,:),mag(2,:));

%Compute calibration parameters

soft_calib=[cos(e.phi),sin(e.phi);-sin(e.phi),cos(e.phi)];
hard_calib=[e.X0_in,e.Y0_in]';
if e.b>=e.a
    scale=[1,0;0,e.a/e.b];
else
    scale=[e.b/e.a,0;0,1];
end
cal=[scale*soft_calib,hard_calib];
mag_cal = scale*soft_calib*(mag(1:2,:)-repmat(hard_calib,1,length(mag)));

hold on;
scatter(mag_cal(1,:),mag_cal(2,:));
title('Calibrated Magnetometer readings(in Gauss)');
hold off;
end