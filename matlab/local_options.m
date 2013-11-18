%% Load a list of wanted topic
topics = loadTopic('/topics/topics.txt');

%% Find rosbag toolboox -- PLEASE PUT YOUR PATH HERE
addpath(genpath('/usr/local/MATLAB/R2013a/toolbox/rosbag/'));

%% A folder with a .bag files -- PLEASE PUT YOUR PATH HERE
path_to_bag_files = ('/media/neosh/5FB92F7D501A5B3A/Clopema/'); 