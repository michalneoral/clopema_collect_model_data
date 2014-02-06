function [ rgb_back ] = loadBackgroundRGB( path_to_bag_files, name )
%LOADBACKGROUNDRGB load a picture of background in rgb mode
%   

x_size=640;
y_size=480;
picture_n=5;

topics=cell(1,1);
topics{1,1}='/xtion1/rgb/image_raw';

path_and_bagfile = strcat(path_to_bag_files, name);
bag_background = ros.Bag(path_and_bagfile);
[msgs_back] = bagToStruct(bag_background,topics);
rgb_back = normalizeRGB (queueToImage(msgs_back{getTopicPosition(msgs_back, '/xtion1/rgb/image_raw'),1}{1,picture_n}.data,x_size,y_size));

end

