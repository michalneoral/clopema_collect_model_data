function [ image3D ] = getDepthImageRaw( queue )

first=zeros(480, 640);
second=first;

% lenght_of_front = size(queue) / res_X / res_Y;

index=1;
for i=1:480
    for j=1:640
        first(i,j)=queue(index);
        second(i,j)=queue(index+1);
        index=index+2;
    end
end

image3D=first+second.*(256);
max(max(image3D))
figure()
colormap(gray(max(max(image3D))));
image(image3D);

for i=1:480
    for j=1:640
        if first(i,j) == 0 && second(i,j)==0
            image3D(i,j)=NaN;
        end
    end
end

% figure()
% colormap(gray(256));
% image(first)
% figure()
% image(second)


end

