for i=1:50
    imshow (front{2,i})
    saveas(sprintf('img%d.tif',i))
end