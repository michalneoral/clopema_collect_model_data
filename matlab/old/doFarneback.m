function [ images ] = doFarneback( msgs, rgb_back, startPoints )

tic
    [front,optFlow] = frontOfImagesOptFlow(msgs,rgb_back);
t=toc;
disp(t);
tic
    [ chain ] = chainOfPoints(startPoints, optFlow );
t=toc;
disp(t);
tic
    [ images ] = addPointsToImagesFromFront( front, chain );
t=toc;
disp(t);

end

