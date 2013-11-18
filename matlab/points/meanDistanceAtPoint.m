function [ meanDist ] = meanDistanceAtPoint( front, points, winSize )

    if nargin < 3
        winSize = 3;
    end
    frontSize=size(front,2);
    
    meanDist=zeros(size(points,1),frontSize);
    
    for i=1:frontSize
        meanDist(:,i) = getMeanDistAtSingleIm (front{3,i}, points, winSize);
    end


end

function [ distAtPoints ] = getMeanDistAtSingleIm ( distImage , points, winSize)
    distAtPoints = zeros(size(points,1),1);
    for i=1:size(points,1)
        distAtPoints(i,1) = getMeanDistAtSinglePoint ( distImage , points{i,1}, winSize);
    end
end

function [ distAtPoint ] = getMeanDistAtSinglePoint ( distImage , point, winSize)
    modWS = mod(winSize,2);
    leftUp = (winSize-modWS)/2;
    rightDown = (winSize-modWS)/2 - (1-modWS);
    if ~ (point(1) - (winSize-modWS)/2 <= 0 || point(2) - (winSize-modWS)/2 <= 0 || point(1) - (winSize-modWS)/2 > size(distImage,1) || point(2) - (winSize-modWS)/2 > size(distImage,2))
        distAtPoint = mean( mean( distImage( point(1)-leftUp:point(1)+rightDown, point(2)-leftUp:point(2)+rightDown )));
    else
        distAtPoint = NaN;
    end
    
%     distAtPoint = mean( mean( distImage( 100:105, 319:321 )));

end