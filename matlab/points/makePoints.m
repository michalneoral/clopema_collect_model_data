function [ points ] = makePoints( front, x, y, num)

pic=~isnan(front{3,num});
edge=50;

image(pic);

updown=zeros(size(pic,1),1);
leftright=zeros(1,size(pic,2));

size(updown)
size(pic)


for i=1:size(pic,2)
    updown=updown+pic(:,i);
end

for i=1:size(pic,1)
    leftright=leftright+pic(i,:);
end

leftright(1:200)=0;

left=0;
for i=1:size(pic,2)
    
    if leftright(i)>0    
        right=i;
        if left==0
            left=i;
        end
    end
end

up=0;
for i=1:size(pic,1)
    
    if updown(i)>0    
        down=i;
        if up==0
            up=i;
        end
    end
end

deltax=floor(abs(right-left-2*edge)/x);
deltay=floor(abs(down-up-2*edge)/y);

% B=[left,right,up,down,deltax,deltay];

points=cell(x*y,1);
for i=1:x
    for j=1:y
        points{(y*(i-1))+j,1}=[left+edge+floor(deltax/2)+deltax*(i-1),up+edge+floor(deltay/2)+deltay*(j-1)];
    end
end

end

