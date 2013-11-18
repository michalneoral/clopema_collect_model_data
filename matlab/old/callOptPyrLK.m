function [ prevPts, nextPts, status, err] = callOptPyrLK( im1, im2 )

prevIm = rgb2gray(im1).*255;
nextIm = rgb2gray(im2).*255;
% prevPts = cv.goodFeaturesToTrack(prevIm,'MaxCorners',5000, 'QualityLevel', 0.001, 'BlockSize', 20);
% [ nextPts, status, err ] = cv.calcOpticalFlowPyrLK(prevIm, nextIm, prevPts, 'WinSize', [50 50], 'MaxLevel', 8);

 prevPts = cv.goodFeaturesToTrack(prevIm,'QualityLevel', 0.005, 'BlockSize', 20);
 [ nextPts, status, err ] = cv.calcOpticalFlowPyrLK(prevIm, nextIm, prevPts);


imaf1=im1;
imaf2=im2;

for i=1:size(prevPts,2)
    imaf1(prevPts{1,i}(2),prevPts{1,i}(1),1)=1;
end
for i=1:size(nextPts,2)
    imaf2(round(nextPts{1,i}(2)),round(nextPts{1,i}(1)),1)=1;
end

subplot(1,2,1);
image(imaf1);
subplot(1,2,2);
image(imaf2);

end

