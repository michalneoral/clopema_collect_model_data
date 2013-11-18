function [msgs_and_meta] = bagToStruct(bag,topic)
% clopema_model_by_vision
% Michal Neoral
msgs_and_meta=cell(size(topic,1),3);

for i = 1:size(topic, 1)

    [msgs_and_meta{i,1}, msgs_and_meta{i,2}] = bag.readAll(topic(i));
    msgs_and_meta{i,3}=topic(i);
    
end
