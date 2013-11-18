function [ centers ] = findCenterOfFabric( front )

    centers=cell(1,size(front,2));
    for i=1:size(front,2)
        centers(1,i)= {getCenter(rgb2gray(leftUpCroopImage(front{2,i},0)))};
    end

end

function [cent] = getCenter(im)
    im= (im ~= 0);
    cent=im;
    for i=1:size(im,1)
        cent(i,:)= findMiddlePixel(im(i,:));
    end
end

function [ cbRow ] = findMiddlePixel(cbRow)
    lastOcc=0;
    firstOcc = 0;
    for i=1:size(cbRow,2)
        if cbRow(1,i)==1            
            if lastOcc < i
                lastOcc = i;
            end
            if firstOcc == 0
                firstOcc = i;
            end
        end
    end
    cbRow(:)=0;
    if (firstOcc ~= 0) && (lastOcc ~= 0)
        cbRow( 1, round((lastOcc + firstOcc)/2) ) = 1;
    end
end