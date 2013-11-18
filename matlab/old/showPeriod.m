function [ periodMatrix ] = showPeriod( msgs, show )

    topics={
    '/xtion1/depth/image_raw';
    '/xtion1/rgb/image_raw';        
    };

    order=zeros(size(topics,1),1);
    for i=1:size(topics,1)
        order(i)=getTopicPosition(msgs, topics{i,1});
        num=size(msgs{order(i),1},2);
        for j=1:num-1
            periodMatrix(i,j,1) = getTimeOfImage(msgs, order(i), j+1) - getTimeOfImage(msgs, order(i), j);
            periodMatrix(i,j,2) = 1/periodMatrix(i,j,1);
        end            
    end

    
    

end

