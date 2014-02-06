%% get number of wanted topic
function [ n ] = getTopicPosition( msgs, name )
    for n=1:size(msgs,1)
       if strcmp(msgs{n,3}, name)
           break;
       end
    end
end