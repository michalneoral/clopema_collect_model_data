function [ filtredImage, maskImage] = motionDetection( image1,image2,openMask )
    if nargin < 3
        openMask=15;
    end
offset = 0.1;
%% Masked part of picture - this is a part of picture where is a visible part of manipulator. This is a mistake and must be removed.
A=ones(480,640);
A(1:100,1:200)=0;

    
%% determine the difference between the reference and the desired image
maskImage = abs(image1-image2) >= offset;
maskImage(:,:,1) = (maskImage(:,:,1)+maskImage(:,:,2)+maskImage(:,:,3)) >= 1-offset;

%% mathematical morphology opening
openingMask = ones (openMask);
maskImage(:,:,1) = imopen(maskImage(:,:,1),openingMask);

%%
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