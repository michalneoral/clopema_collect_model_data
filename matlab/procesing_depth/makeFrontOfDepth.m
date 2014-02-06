% clopema_model_by_vision
% Michal Neoral

%% funkce ktera vytridi z msgs pouze hloubkovou mapu a casovou znacku
function [ frontOfDepth ] = makeFrontOfDepth( msgs )
%% 
%
topic = '/xtion1/depth/image_raw';
pos=getTopicPosition(msgs, topic);

quantity=size(msgs{pos,1},2);
frontOfDepth=cell(1,quantity);
for i=1:quantity
    [ pcloud, distance ] = getCloud( msgs{pos,1}{1,i}.data, true);
    frontOfDepth(1,i) = {distance};
end
frontOfDepth(2,:) = getTimeOfTopicEvent( msgs, pos, quantity);


end
