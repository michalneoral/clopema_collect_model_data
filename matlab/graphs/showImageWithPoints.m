if ~ exist('countImage','var')
    countImage=1;
end
if countImage > size(images,2)
    countImage=1;
end
% hFig = figure(1);
% set(gcf,'PaperPositionMode','auto')
% set(hFig, 'Position', [50 50 1000 800])
imshow(images{1,countImage})

countImage=countImage+1;