function [ images ] = video( queue )
m=size(queue);
images = zeros(480,640,3,m);
for i=1:m(2)
    images(:,:,:,i)=doRGB(queue{1,i}.data);
end 



end