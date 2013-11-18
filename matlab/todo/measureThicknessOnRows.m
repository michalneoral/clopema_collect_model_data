function [ thicknessRGB, thicknessDepth ] = measureThicknessOnRows( front, rows )

    thicknessRGB=zeros(size(rows,1),size(front,2));
    thicknessDepth=zeros(size(rows,1),size(front,2));
    for i=1:size(front,2)
        thicknessRGB(:,i)=getThicknessInSingleImage (leftUpCroopImage(rgb2gray(front{2,i}), 0), rows);  % crop
        thicknessDepth(:,i)=getThicknessInSingleImage (leftUpCroopImage(front{3,i}, NaN), rows);        % crop
    end

end

function [ thicknessSingleImage ] = getThicknessInSingleImage ( im, rows)
    thicknessSingleImage = zeros (size(rows,1),1);
    for i=1:size(rows,1)
        thicknessSingleImage(i,1)= getThincknessInSingleRaw (im,rows(i,1));
    end
end

function [ thickness ] = getThincknessInSingleRaw (im,row)
    if size(im,2)==numel(find(~isnan(im(row,:))))
        thickness=numel(find(im(row,:)));
    else
        thickness=numel(find(~isnan(im(row,:))));
    end
end