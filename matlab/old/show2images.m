function [ ] = show2images( n1,n2,msgs,rgb_back )

im1 = queueToImage(msgs{8,1}{1,n1}.data)./255;
im2 = queueToImage(msgs{8,1}{1,n2}.data)./255;

im1f = motionDetection(im1, rgb_back);
im2f = motionDetection(im2, rgb_back);

figure(1)
image(im1f)
figure(2)
image(im2f)

end

