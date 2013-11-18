function [ picture ] = doRGB( queue )
res_X=480;
res_Y=640;
%make picture from queue

rgb=zeros(res_X, res_Y, 3);

% lenght_of_front = size(queue) / res_X / res_Y;

index=1;
for i=1:res_X
    for j=1:res_Y
        rgb(i,j,1)=queue(index);
        rgb(i,j,2)=queue(index+1);
        rgb(i,j,3)=queue(index+2);
        index=index+3;
    end
end
    
picture = reshape(rgb, res_X, res_Y, 3); % reshape pulls columnwise, assume 6x2 image
picture = picture/255; %scale the data to be between 0 and 1
image(picture);
end

