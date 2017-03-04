% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3481.384495753868123 ; 3430.280982847134055 ];

%-- Principal point:
cc = [ 1971.032524762250205 ; 1519.583891281920614 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.046046352213990 ; -0.000000000000000 ; 0.001578995778674 ; -0.001777123530152 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.909251992190454 ; 0.854859556507562 ];

%-- Principal point uncertainty:
cc_error = [ 2.180341871289276 ; 1.796642856221520 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.000585104103958 ; 0.000000000000000 ; 0.000206014851812 ; 0.000250138181664 ; 0.000000000000000 ];

%-- Image size:
nx = 4032;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 17;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 0 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.906219e+00 ; 1.522101e+00 ; -1.223808e+00 ];
Tc_1  = [ 3.590480e+01 ; 1.007975e+02 ; 3.430218e+02 ];
omc_error_1 = [ 6.347455e-04 ; 4.030246e-04 ; 7.553999e-04 ];
Tc_error_1  = [ 2.173623e-01 ; 1.795169e-01 ; 9.614423e-02 ];

%-- Image #2:
omc_2 = [ -1.391997e+00 ; 1.887382e+00 ; -1.011632e+00 ];
Tc_2  = [ 5.191230e+01 ; 3.385798e+01 ; 3.710906e+02 ];
omc_error_2 = [ 5.596800e-04 ; 4.830100e-04 ; 7.029808e-04 ];
Tc_error_2  = [ 2.325039e-01 ; 1.939643e-01 ; 8.751829e-02 ];

%-- Image #3:
omc_3 = [ -1.515236e+00 ; 1.499559e+00 ; -1.209095e+00 ];
Tc_3  = [ -2.444002e+01 ; 6.997836e+01 ; 3.774457e+02 ];
omc_error_3 = [ 5.882299e-04 ; 4.413788e-04 ; 6.545382e-04 ];
Tc_error_3  = [ 2.379601e-01 ; 1.972685e-01 ; 8.723683e-02 ];

%-- Image #4:
omc_4 = [ 1.695585e+00 ; -1.787761e+00 ; 1.435538e+00 ];
Tc_4  = [ 9.960155e+01 ; 6.842657e+01 ; 2.219491e+02 ];
omc_error_4 = [ 3.701926e-04 ; 6.044262e-04 ; 7.942432e-04 ];
Tc_error_4  = [ 1.416427e-01 ; 1.211252e-01 ; 9.553771e-02 ];

%-- Image #5:
omc_5 = [ -1.680692e+00 ; 1.623926e+00 ; 6.104594e-01 ];
Tc_5  = [ 9.413021e+01 ; 3.882336e+00 ; 3.773927e+02 ];
omc_error_5 = [ 4.330881e-04 ; 5.231235e-04 ; 7.603420e-04 ];
Tc_error_5  = [ 2.357431e-01 ; 2.009375e-01 ; 1.086940e-01 ];

%-- Image #6:
omc_6 = [ -1.178282e+00 ; 1.908276e+00 ; 6.453277e-01 ];
Tc_6  = [ 6.664224e+01 ; -2.981028e+01 ; 5.184669e+02 ];
omc_error_6 = [ 3.927966e-04 ; 6.527951e-04 ; 7.808159e-04 ];
Tc_error_6  = [ 3.255911e-01 ; 2.714498e-01 ; 1.572681e-01 ];

%-- Image #7:
omc_7 = [ -1.186899e+00 ; 1.494786e+00 ; -1.549894e-01 ];
Tc_7  = [ -3.749434e+00 ; -2.388757e+01 ; 4.008406e+02 ];
omc_error_7 = [ 4.283491e-04 ; 5.470423e-04 ; 5.913695e-04 ];
Tc_error_7  = [ 2.526150e-01 ; 2.097311e-01 ; 8.649098e-02 ];

%-- Image #8:
omc_8 = [ 1.509228e+00 ; -1.712021e+00 ; 4.220685e-01 ];
Tc_8  = [ 1.673895e+01 ; 2.892720e+00 ; 3.724783e+02 ];
omc_error_8 = [ 4.667309e-04 ; 5.904056e-04 ; 7.565740e-04 ];
Tc_error_8  = [ 2.346564e-01 ; 1.953613e-01 ; 1.467581e-01 ];

%-- Image #9:
omc_9 = [ -2.124011e+00 ; 2.172785e+00 ; -1.133526e-01 ];
Tc_9  = [ 9.242528e+01 ; 6.065289e+01 ; 3.832108e+02 ];
omc_error_9 = [ 6.802128e-04 ; 7.014776e-04 ; 1.486643e-03 ];
Tc_error_9  = [ 2.410763e-01 ; 2.025100e-01 ; 1.412143e-01 ];

%-- Image #10:
omc_10 = [ 1.921899e+00 ; -1.939332e+00 ; 3.331721e-01 ];
Tc_10  = [ 8.593010e+01 ; 4.696227e+01 ; 2.096392e+02 ];
omc_error_10 = [ 3.734310e-04 ; 5.073814e-04 ; 8.427538e-04 ];
Tc_error_10  = [ 1.341365e-01 ; 1.150341e-01 ; 9.448351e-02 ];

%-- Image #11:
omc_11 = [ -1.943648e+00 ; 2.358066e+00 ; 4.078664e-01 ];
Tc_11  = [ 1.375794e+02 ; 4.800856e+01 ; 3.181600e+02 ];
omc_error_11 = [ 4.946808e-04 ; 6.018402e-04 ; 1.204624e-03 ];
Tc_error_11  = [ 2.021968e-01 ; 1.730650e-01 ; 1.360492e-01 ];

%-- Image #12:
omc_12 = [ -1.483832e+00 ; 1.542342e+00 ; -1.150364e+00 ];
Tc_12  = [ -6.818255e+01 ; 5.878205e+01 ; 5.268847e+02 ];
omc_error_12 = [ 6.019300e-04 ; 4.864163e-04 ; 7.026408e-04 ];
Tc_error_12  = [ 3.338940e-01 ; 2.772995e-01 ; 1.470465e-01 ];

%-- Image #13:
omc_13 = [ -2.264015e+00 ; 8.644725e-01 ; -1.071965e+00 ];
Tc_13  = [ -3.432827e+01 ; 1.034109e+02 ; 4.074917e+02 ];
omc_error_13 = [ 6.490836e-04 ; 3.409244e-04 ; 8.285279e-04 ];
Tc_error_13  = [ 2.572965e-01 ; 2.140068e-01 ; 1.192099e-01 ];

%-- Image #14:
omc_14 = [ -2.136926e+00 ; 2.148508e+00 ; -3.814742e-01 ];
Tc_14  = [ 3.976637e+01 ; 7.716914e+01 ; 3.792155e+02 ];
omc_error_14 = [ 6.346334e-04 ; 6.985218e-04 ; 1.444374e-03 ];
Tc_error_14  = [ 2.394203e-01 ; 1.998364e-01 ; 1.365304e-01 ];

%-- Image #15:
omc_15 = [ 1.857728e+00 ; -1.848526e+00 ; -1.138556e-01 ];
Tc_15  = [ 5.003143e+01 ; 3.675125e+01 ; 1.999880e+02 ];
omc_error_15 = [ 4.619194e-04 ; 4.912795e-04 ; 7.978260e-04 ];
Tc_error_15  = [ 1.271276e-01 ; 1.064986e-01 ; 8.138476e-02 ];

%-- Image #16:
omc_16 = [ 1.509629e+00 ; -1.558372e+00 ; -6.105452e-01 ];
Tc_16  = [ 4.855432e+01 ; 5.792182e+01 ; 1.820977e+02 ];
omc_error_16 = [ 5.100769e-04 ; 4.795982e-04 ; 6.383031e-04 ];
Tc_error_16  = [ 1.189316e-01 ; 9.820346e-02 ; 7.933707e-02 ];

%-- Image #17:
omc_17 = [ -1.395893e+00 ; 2.081606e+00 ; -9.693811e-01 ];
Tc_17  = [ 5.710567e+01 ; 8.949886e+00 ; 4.567826e+02 ];
omc_error_17 = [ 5.808681e-04 ; 5.149444e-04 ; 7.976333e-04 ];
Tc_error_17  = [ 2.863588e-01 ; 2.390527e-01 ; 1.229199e-01 ];

