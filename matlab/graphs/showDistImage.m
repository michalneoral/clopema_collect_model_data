if ~ exist('countImage','var')
    countImage=1;
end
if countImage > size(front,2)
    countImage=1;
end

surf(front{3,countImage},'EdgeColor','none');
view(0,-90);
rotate3d off;
colormap(jet);
grid on;
axis equal;
countImage=countImage+1;