function [image] = normalizeRGB (image,res_X,res_Y)
    if nargin < 3
        res_Y=480;
        res_X=640;
    end
    picture = reshape(image, res_Y, res_X, 3);
    image = picture/255;
    %image(picture);
end