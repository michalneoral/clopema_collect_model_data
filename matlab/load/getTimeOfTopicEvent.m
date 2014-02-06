%% return time of stamp
function [ time ] = getTimeOfTopicEvent( msgs, n_topic, events )
time = cell(1,events);
    for i=1:events
        time(1,i) = {msgs{n_topic, 1}{1, i}.header.stamp.time};
    end
end