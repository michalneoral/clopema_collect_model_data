function [ images ] = images3D( queue )
m=size(queue);
images = zeros(480,640,m);
for i=1:m(2)
    images(:,:,i)=doImageXtion(queue{1,i}.data);
end 
end

