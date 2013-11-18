function [ speed ] = showPlotOfDistancesInTime( dist, queue, points )

    timeStamp = zeros (1,size(queue,2));
    for i=1:size(queue,2)
        timeStamp(1,i)=queue{1, i}(1,2);        
    end
    
    fig=figure(1);
    clf(fig);
    hold all;
    for i=1:size(dist,1)
        plot( timeStamp, dist(i,:),'-*');
        title('Vzdalenost od kamery');
        xlabel('s');
        ylabel('m');
    end
    grid on
    hold off
    
    speed=zeros(size(dist,1),size(dist,2)-1);
    for i=1:size(queue,2)-1
        speed(:,i)= (dist(:,i+1)-dist(:,i))/(timeStamp(1,i+1)-timeStamp(1,i));   
    end
% 
    fig=figure(2);
    clf(fig);
    hold all;
    for i=1:size(speed,1)
        plot( (timeStamp(1:end-1)+timeStamp(2:end))/2, speed(i,:),'-*');
        title('Rychlost bodu');
        xlabel('s');
        ylabel('m/s');
    end
    grid on
    hold off
    
    fig=figure(3);
    clf(fig);
    hold all;
    for i=1:size(dist,1)
        plot( timeStamp, dist(i,:));
    end
    for i=1:size(speed,1)
        plot( (timeStamp(1:end-1)+timeStamp(2:end))/2, speed(i,:)/2);
    end
    grid on
    hold off
    
end

