
function [image] = queueToImageRGB (queue,res_X,res_Y)
    if nargin < 2
        res_X=640;
        res_Y=480;
    end
    sizeOfColor = size(queue,1)/res_X/res_Y;
    image=zeros(res_Y,res_X,sizeOfColor);
    count=1;
    for i=1:res_Y
        for j=1:res_X
            for k=1:sizeOfColor
                image(i,j,k)=queue(count);
                count=count+1;
            end
        end
    end    
end