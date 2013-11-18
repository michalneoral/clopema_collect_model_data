function [ filtredImage, maskImage] = motionDetection( image1,image2 )

offset = 0.1;
    
maskImage = abs(image1-image2) >= offset;

maskImage(:,:,1) = (maskImage(:,:,1)+maskImage(:,:,2)+maskImage(:,:,3)) >= 1-offset;

%% mathematical morphology opening
openingMask = ones (15);
maskImage(:,:,1) = imopen(maskImage(:,:,1),openingMask);

%%
A=ones(480,640);
A(1:100,1:200)=0;
maskImage(:,:,1) = maskImage(:,:,1).*A;
maskImage(:,:,2) = maskImage(:,:,1);
maskImage(:,:,3) = maskImage(:,:,2);

maskImage = nullToNan(maskImage);


filtredImage = maskImage .* image1;



end

function [Mask] = nullToNan(Mask)
    Mask=double(Mask);
    Mask(Mask==0)=nan;
end