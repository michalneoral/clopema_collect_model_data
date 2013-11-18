% Find closed time and return number of closed image

function [ nclose ] = findMostClosed( msgs, topics, nfile )

    quantity_of_topics = size(topics,1);
    order_of_topics = zeros (quantity_of_topics,1);
    nclose = zeros(quantity_of_topics,2);
    
    for i = 1:quantity_of_topics
        order_of_topics(i)=getTopicPosition(msgs, topics{i,1});
    end
        
    if nfile > 0 && nfile < size(msgs{order_of_topics(1),2},2);
        time = getTimeOfImage(msgs, order_of_topics(1), nfile);
        nclose(1,1) = nfile;
        nclose(1,2) = time-getTimeOfImage( msgs, order_of_topics(1), 1);
        nclose(1,3) = order_of_topics(1);
            for i = 2:quantity_of_topics
                nclose(i,1) = getMostClosed( time, msgs, order_of_topics(i), nfile );
                nclose(i,2) = getTimeOfImage( msgs, order_of_topics(i), nclose(i,1))-time;
                nclose(i,3) = order_of_topics(i);
            end
%     else
%         disp('Too big number of images');
    end
end