function [ msgs ] = loadBagFile( path_to_bag_files, topics, name )
%LOADBAGFILE Loading bag files to variable
%

path_and_bagfile = strcat(path_to_bag_files, name);
bag = ros.Bag(path_and_bagfile);
baginfo=bag.info();
disp(baginfo);
msgs = bagToStruct(bag,topics);

end

