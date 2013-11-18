function [ picture ] = doMono( queue , res_X, res_Y, type)

%make picture from queue

grey=zeros(res_X, res_Y);


% lenght_of_front = size(queue) / res_X / res_Y;

index=1;
for i=1:res_X
    for j=1:res_Y        
        grey(i,j)=queue(index);
        index=index+1;
    end
end
    
picture=grey;
colormap(type);
image(grey);

end

