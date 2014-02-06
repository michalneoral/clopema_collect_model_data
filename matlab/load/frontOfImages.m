function [ frontConnect , info , frontDist, frontRGB ] = frontOfImages( msgs, rgb_back )
    
    %dodelat frontDist, frontRGB samostatne vse
    frontDist=1;frontRGB=1;

    topics={
    '/xtion1/depth/image_raw';
    '/xtion1/rgb/image_raw';        
    };
    offset=1.0000e-03;
    queue = makeQueueOfClosedTopics(msgs,topics);
    index=0;

    for i=1:size(queue,1)-1
        if( abs(queue{i, 1}(2,2))<offset  )
              index=index+1;
        end
    end
    
    frontConnect=cell(3,index);
    info=cell(1,index);
    index=0;
    
    
    for i=1:size(queue,1)-1
        if( abs(queue{i, 1}(2,2))<offset  )
                index=index+1;
                [ pcloud, distance ] = getCloud( msgs{ queue{1, 1}(1,3),1 }{ 1,queue{i, 1}(1,1) }.data, true);
                im=queueToImageRGB(msgs{queue{1, 1}(2,3),1}{1,queue{i, 1}(2,1)}.data)./255;
                imf=motionDetection(im,rgb_back);
                frontConnect(:,index) = {im, imf, distance};
                info(:,index)= queue(i,:);
        end
    end 
    
%     index=0;
% 
%     for i=1:size(queue,1)-1
%         if( queue{i, 1}(1,1)~=queue{i+1, 1}(1,1) && queue{i, 1}(2,1)~=queue{i+1, 1}(2,1) )
%               index=index+1;
%         end
%     end
%     
%     front=cell(3,index);
%     
%     index=0;
%     
%     
%     for i=1:size(queue,1)-1
%         if( queue{i, 1}(1,1)~=queue{i+1, 1}(1,1) && queue{i, 1}(2,1)~=queue{i+1, 1}(2,1) )
%                 index=index+1;
%                 [ pcloud, distance ] = getCloud( msgs{ queue{1, 1}(1,3),1 }{ 1,queue{i, 1}(1,1) }.data, true);
%                 im=queueToImage(msgs{queue{1, 1}(2,3),1}{1,queue{i, 1}(2,1)}.data)./255;
%                 imf=motionDetection(im,rgb_back);
%                 front(:,index) = {im, imf, distance};
%         end
%     end 
end

function [queue] = makeQueueOfClosedTopics(msgs,topics)
    pos=getTopicPosition(msgs, topics{1,1});
    quantity=size(msgs{pos,1},2);
    queue=cell(quantity,1);
    for i=1:quantity
        queue(i,:) = {findMostClosed( msgs, topics, i)};
    end
end