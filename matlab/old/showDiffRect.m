 figure(1)
 image=doRGB(msgs{11, 1}{1, 41}.data);
 
 figure(2)
 [ pcloud, distance ] = getCloud( msgs{7,1}{1,21}.data , true);
surf(distance,image,'EdgeColor','none');
view(0,-90);

figure(3)
[ pcloud, distance ] = getCloud( msgs{8,1}{1,16}.data , true);
surf(distance,image,'EdgeColor','none');
view(0,-90);

figure(4)
image=doRGB(msgs{21, 1}{1, 7}.data);

figure(5)
[ pcloud, distance ] = getCloud( msgs{7,1}{1,21}.data , true);
surf(distance,image,'EdgeColor','none');
view(0,-90);

figure(6)
[ pcloud, distance ] = getCloud( msgs{8,1}{1,16}.data , true);
surf(distance,image,'EdgeColor','none');
view(0,-90);
