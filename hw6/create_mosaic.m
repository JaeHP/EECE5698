close all
clear
addpath('matlab')
addpath('matlab/TOOLBOX_calib/')
addpath('data/calib')
%% Load Images

ls data;
dat_dir = char(input('Enter the folder name (from the list) containing images for mosaicing:','s'));
dat_dir = fullfile('data',dat_dir);
dat = imageDatastore(dat_dir);
numImages = numel(dat.Files);
% Undistort images
x = input('Undistort image dataset? (yes=1, no=0):');
if x
   load Calib_Results.mat  cc fc kc alpha_c;
   cameraParams = cameraParameters('IntrinsicMatrix',[fc(1),0,0;alpha_c,fc(2),0;cc(1),cc(2),1],'RadialDistortion',[kc(1),kc(2),kc(5)],'TangentialDistortion',[kc(3),kc(4)]);
   for i=1:numImages
       [I,~] = undistortImage(readimage(dat,i),cameraParams);
       imwrite(I,char(strcat(dat_dir,'/calib/img',string(i),'.jpg')));
   end
   clear I i fc alpha_c cc kc cameraParams
end
dat_dir = fullfile(dat_dir,'calib');
dat = imageDatastore(dat_dir);
clear dat_dir x;

%Display images to be stitched
% montage(dat.Files);

%% Get transform pairs relative to center image
% Read the first image from the image set.
I = readimage(dat, 1);

% Initialize features for I(1)
grayImage = rgb2gray(I);
% [tile(2),tile(1)] = size(grayImage);
% tile = ceil(tile/50);
tile = [50 50];   %Experimented with differents values to get optimum value
[points(:,2),points(:,1),~] = harris(grayImage,5000,'tile',tile);
[features, points] = extractFeatures(grayImage, points,'blockSize',21);

% Initialize all the transforms to the identity matrix.
tforms(numImages) = projective2d(eye(3));

% Iterate over remaining image pairs
for n = 2:numImages

    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;
    clear points features;
    % Read I(n).
    I = readimage(dat, n);
    grayPrev = grayImage;
    % Detect and extract SURF features for I(n).
    grayImage = rgb2gray(I);
    [points(:,2),points(:,1),~] = harris(grayImage,5000,'tile',tile);
    [features, points] = extractFeatures(grayImage, points,'blockSize',21);

    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious,'Unique', true);
    
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);
%     showMatchedFeatures(grayPrev,grayImage, matchedPointsPrev, matchedPoints);
    difference = matchedPoints - matchedPointsPrev;
    angle = atan2(difference(:,2),difference(:,1));
    difference = sum(difference.^2,2).^0.5;
    med_diff = median(difference);
    med_angle = median(angle);
    index = find(angle>med_angle-degtorad(30) & angle<med_angle+degtorad(30));
    if length(index) >40
        matchedPoints = matchedPoints(index,:);
        matchedPointsPrev = matchedPointsPrev(index,:);
    end
    disp('Number of matched points')
    disp(length(matchedPoints))
    
    if length(matchedPoints)>3
    % Estimate the transformation between I(n) and I(n-1).
        tforms(n) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,...
            'projective', 'Confidence', 90, 'MaxNumTrials', 4000,'MaxDistance',3);    
    end    
    

    % Compute T(1) * ... * T(n-1) * T(n)
    tforms(n).T = tforms(n-1).T * tforms(n).T;
end
imageSize=size(I);
clear grayImage n features points indexPairs matchedPoints med_diff difference;
clear matchedPointsPrev pointsPrevious featuresPrevious med_angle angle index;
%%
%Making center of the scene less distorted
% Compute the output limits  for each transform
xlim =zeros(numImages,2);
for i = 1:numImages
    [xlim(i,:), ~] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end
avgXLim = mean(xlim, 2);
[~, idx] = sort(avgXLim);
centerIdx = floor((numImages+1)/2);
centerImageIdx = idx(centerIdx);
Tinv = invert(tforms(centerImageIdx));
clear avgXLim idx centerIdx
for i = 1:numImages
    tforms(i).T = Tinv.T * tforms(i).T;
end
clear Tinv
% Initialize panorama
ylim = zeros(numImages,2);
for i = 1:numImages
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end

% Find the minimum and maximum output limits
xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);
%%  Panorama Stitch and show
% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
% Create the panorama.
for i = 1:numImages
    
    I = readimage(dat, i);

    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
%     imsave(warpedImage);
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);

    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
end
figure
imshow(panorama)
%% Get camera positions
% x = sum(xlim,2)/2 - min(min(xlim));
% y = sum(ylim,2)/2 - min(min(ylim));
% hold on;
% plot(x,y,'r.','MarkerSize',25);
