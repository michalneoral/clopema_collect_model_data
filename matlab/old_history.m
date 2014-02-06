%-- 5.11.2013 12:02:39 --%
%-- 9.11.2013 01:19:28 --%
A=[20]
A*A
load('paral_k_40_scheme_c.mat')
%-- 13.11.2013 08:45:17 --%
%-- 13.11.2013 09:59:25 --%
startup
loader
%-- 14.11.2013 03:46:05 --%
startup
addpath(genpath('/usr/local/MATLAB/R2013a/toolbox/rosbag/'));
loader
startup
loader
startup
loader
%-- 14.11.2013 03:58:33 --%
startup
loader
startup
loader
example
startup
loader
example.m
example
ros.Bag
example
startup
loader
startup
loader
%-- 14.11.2013 04:37:02 --%
startup
loader
towel16_0.1_0006_R2.bag
imshow(front{1,1})
imshow(front{1,2})
imshow(front{2,1})
imshow(front{3,1})
image(front{3,1})
image(front{5,1})
image(front{3,5})
imshow(front{3,1})
imshow(front{2,1})
imsave
loader
towel16_1.0_0007_R2.bag
imshow(front{2,1})
imsave /home/neosh/obr1.jpg
saveImagesSeparately
dd
%-- 15.11.2013 08:44:38 --%
startup
loader
towel16_1.0_0007_R2.bag
imshow(front{2,1})
loader
towel16_1.0_0007_R2.bag
imshow(front{2,1})
loader
towel16_1.0_0007_R2.bag
imshow(front{2,1})
imshow(front{1,1})
imshow(front{2,1})
points=makePoints(front,1,1,1);
showDistImage
points=makePoints(front,1,1,1);
showDistImage
points=makePoints(front,1,1,1);
showDistImage
imsave
showDistImage
A=ones(480,640);
A(1:100,1:150)=0;
showDistImage
A(1:100,1:150)=0;
[ meanDist ] = meanDistanceAtPoint( front, points, winSize )
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
points=makePoints(front,1,1,1);
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
showDistImage
points=makePoints(front,1,1,1);
points=makePoints(front,1,1,10);
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
points=makePoints(front,3,3,10);
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
points=makePoints(front,1,1,10);
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
points=makePoints(front,1,1,10);
[ meanDist ] = meanDistanceAtPoint( front, points, 3 )
showPlotOfDistancesInTime
showPlotOfDistancesInTime( meanDist, queue, points )
%-- 18.11.2013 08:30:04 --%
startup
local_options
startup
loader
startup
loader
startup
loader
towel16_1.0_0007_R2.bag
startup
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
startup
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
loader
towel16_0.1_0006_R2.bag
reader
startup
genpath('./')
startup
showDistImage
startup
loader
towel16_0.1_0006_R2.bag
showDistImage
towel16_0.1_0006_R2.bag
showDistImage
showDiffRect
startup
loader
https://github.com/michalneoral/collect_data_documentation/
raw/master/manual_collect_data(cze).pdf

%-- 3.12.2013 06:59:26 --%
startupCloPeMa
loader
towel16_0.1_0006_B1.bag
loader
towel16_0.1_0006_B1.bag
startup
loader
startup
loader
towel16_0.1_0006_B1.bag
startup
loader
towel16_0.1_0006_B1.bag
startup
loader
towel16_0.1_0006_B1.bag
startup
loader
towel16_0.1_0006_B1.bag
startup
loader
towel16_0.1_0006_B1.bag
[front, queue] = frontOfImages(msgs,rgb_back);
rgb_back(:,:,1)
image(rgb_back)
startup
loader
towel16_0.1_0006_B1.bag
image(rgb_back)
[front, queue] = frontOfImages(msgs,rgb_back);
startup
loader
towel16_0.1_0006_B1.bag