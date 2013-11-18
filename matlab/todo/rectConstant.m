function [ rect ] = rectConstant( msgs, topic )

% Function to load rectification arguments

if(nargin < 2)
    topic = '/xtion1/rgb/camera_info';
end

ntopic = getTopicPosition(msgs, topic);

K=zeros(3);
R=zeros(3);
P=zeros(3,4);

D = msgs{ntopic, 1}{1, 1}.D;

for i = 1:3
    for j = 1:3
        K(i,j) = msgs{ntopic, 1}{1, 1}.K((i-1)*3+j);
        R(i,j) = msgs{ntopic, 1}{1, 1}.R((i-1)*3+j);
    end
end

for i = 1:3
    for j = 1:4
        P(i,j) = msgs{ntopic, 1}{1, 1}.P((i-1)*4+j);
    end
end

rect = struct('D', D , 'K', K , 'R', R , 'P', P );

end

