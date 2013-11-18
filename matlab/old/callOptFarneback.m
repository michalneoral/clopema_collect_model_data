function [ flow ] = callOptFarneback( im1, im2 )

prevImg = rgb2gray(im1).*255;
nextImg = rgb2gray(im2).*255;

flow = cv.calcOpticalFlowFarneback(prevImg, nextImg,'PyrScale', 0.5, 'Levels', 1, 'WinSize', 17, 'Iterations', 5, 'PolyN', 5, 'PolySigma', 1.1,'Gaussian', true);

end

