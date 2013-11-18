function [ front , optFlow ] = frontOfImagesOptFlow( msgs, rgb_back )
    topics={
    '/xtion1/depth/image_raw';
    '/xtion1/rgb/image_raw';        
    };
    queue = makeQueueOfClosedTopics(msgs,topics);    

    index=1;

    
    
    for i=1:size(queue,1)-1
        if( queue{i, 1}(1,1)~=queue{i+1, 1}(1,1) && queue{i, 1}(2,1)~=queue{i+1, 1}(2,1) )
                [ pcloud, distance ] = getCloud( msgs{ queue{1, 1}(1,3),1 }{ 1,queue{i, 1}(1,1) }.data, true);
                front(:,index) = {distance,queueToImage(msgs{queue{1, 1}(2,3),1}{1,queue{i, 1}(2,1)}.data)./255};
                index=index+1;
        end
    end
    
    im1f=motionDetection(front{2,1},rgb_back);
    optFlow(:,1) = {round(callOptFarneback(im1f,im1f))};
    
    for i=1:size(front, 2)-1
        im1f=motionDetection(front{2,i},rgb_back);
        im2f=motionDetection(front{2,i+1},rgb_back);
        optFlow(:,i+1) = {round(callOptFarneback(im1f,im2f))};
    end
   
end

function [queue] = makeQueueOfClosedTopics(msgs,topics)
    pos=getTopicPosition(msgs, topics{1,1});
    quantity=size(msgs{pos,1},2);
    queue=cell(quantity,3);
    for i=1:quantity
        queue(i,:) = {findMostClosed( msgs, topics, i)};
    end
end