%% return time of stamp
function [ time ] = getTimeOfImage( msgs, n_topic, n_image )

% get time of image
% i found two different times, *.header.stamp.time is probably better

    %time = msgs{n_topic,2}{1,n_image}.time.time;
    time = msgs{n_topic, 1}{1, n_image}.header.stamp.time;
end