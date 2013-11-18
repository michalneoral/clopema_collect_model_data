%% Clean up a workspace
clear rosbag_wrapper;
clear ros.Bag;
clear all;
clc;

%% Important startup variables
addpath(genpath('./'));
local_options;

%% Only sign
disp('Init startup - [ OK ]');