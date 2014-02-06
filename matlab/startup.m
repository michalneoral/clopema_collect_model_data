%% Clean up a workspace
clear rosbag_wrapper;
clear ros.Bag;
clear all;
clc;

%% Important startup variables
addpath(genpath('./'));
local_options;

%% Only sign
if ~isempty(topics) && ~isempty(path_to_bag_files)
    try
        homedir=cd(path_to_bag_files);
        cd(homedir);
        disp('Init startup is fine. Everyone is happy.');
    catch
        disp('ERROR. Dictionary path_to_bag_files does not exist. Change local_options.m');
    end    
else
    disp('ERROR. Probably something wrong with names in local_options.m');
end