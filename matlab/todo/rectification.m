function [ out ] = rectification( msgs, rect )

preImage = queueToImage(msgs{8,1}{1,5}.data,640,480);
imageRGB = normalizeRGB (preImage);

out = zeros(size(imageRGB));

for i=1:640
    for j=1:480
        for k=1:3
        out(i,j,k) = rect.P * [i,j,imageRGB(i,j,k),1]';
        end
    end
end

image(out);

end

