% clopema_model_by_vision
% Michal Neoral
[msgs] = bagToStruct(bag,topics);
[msgs_back] = bagToStruct(bag_background,topics);
rgb_back = normalizeRGB (queueToImage(msgs_back{getTopicPosition(msgs_back, '/xtion1/rgb/image_raw'),1}{1,5}.data,640,480));
