function [ images ] = addPointsToImagesFromFront( front, points )
    images(1,:)=front(2,:);
    for i=1:size(front,2)
            a=points(:,i);
            images(1,i) = {highlightPoints( front{2, i} , a)} ;            
    end
end

function [im] = highlightPoints(im, points)
    for i=1:size(points,1)
        b = points{i};
        im = MidpointCircle(im, 5, b(1), b(2), 1);
    end
end