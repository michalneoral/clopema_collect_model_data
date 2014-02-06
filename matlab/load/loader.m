% clopema_model_by_vision
% Michal Neoral
nfiles=showNamesInDictionaty (path_to_bag_files);
if nfiles==0
    sprintf('No files in %s or no access',path_to_bag_files)
else
    
clear nfiles;

    %% Load camera background -- Ve verzi pro C upravit jinak
    bagfile_backgroung = 'camera_default_0.bag';
    rgb_back = loadBackgroundRGB( path_to_bag_files, bagfile_backgroung);

    %% Load bagfile
    bagfile = input ('Put name of bag file: ','s');        
    msgs = loadBagFile( path_to_bag_files, topics, bagfile);
    
    %% Prepare struct
    [front, queue] = frontOfImages(msgs,rgb_back);
end