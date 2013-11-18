% clopema_model_by_vision
% Michal Neoral
nfiles=showNamesInDictionaty (path_to_bag_files);
if nfiles==0
    sprintf('No files in %s or no access',path_to_bag_files)
else
    %% Load camera background
    bagfile_backgroung = 'camera_default_0.bag';
        path_and_bagfile_background = strcat(path_to_bag_files, bagfile_backgroung);
        bag_background = ros.Bag(path_and_bagfile_background);
    %% Load bagfile
    bagfile = input ('Put name of bag file: ','s');
        path_and_bagfile = strcat(path_to_bag_files, bagfile);
        bag = ros.Bag(path_and_bagfile);
        bag.info()
        reader
        [front, queue] = frontOfImages(msgs,rgb_back);
end