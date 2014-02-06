function [filtredFrontOfRGB, maskFrontOfRGB] =filtrReferenceFrame(frontOfRGB,referenceFrame,sizeMorpMask)
    if nargin < 3
        sizeMorpMask=15;
    end
dim = size(frontOfRGB,2);
filtredFrontOfRGB=cell(2,dim);
filtredFrontOfRGB(2,:)=frontOfRGB(2,:);
maskFrontOfRGB=filtredFrontOfRGB;

for i=1:dim
[ filtredImage, maskImage] = motionDetection( frontOfRGB{1,i},referenceFrame,sizeMorpMask );
filtredFrontOfRGB(1,i)={filtredImage};
maskFrontOfRGB(1,i)={maskImage};
end

end

