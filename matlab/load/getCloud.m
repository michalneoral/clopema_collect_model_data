function [ pcloud, distance ] = getCloud( queue , reduce)

res_X=480;
res_Y=640;
max_dist = 1.8; % max 2.3, min 1.2

first=zeros(res_X, res_Y);
second=first;

index=1;
for i=1:res_X
    for j=1:res_Y
        first(i,j)=queue(index);
        second(i,j)=queue(index+1);
        index=index+2;
    end
end

queue=first+second.*256;

[pcloud, distance] = depthToCloud(queue);

    if reduce
        for i=1:res_X
            for j=1:res_Y
                if distance(i,j) > max_dist
                        distance(i,j)=NaN;
                end
                if pcloud(i,j,3) > max_dist
                        pcloud(i,j,3)=NaN;
                end
            end
        end
    end

%dopsat odstranění velké vzdálenosti

end

