function [  ] = plotVectors( vector )

hold all;

for j=1:(size(vector,1)/15)
    i=j*15;
%       plot(vector{i,1}(2),vector{i,1}(1),vector{i,2}(2),vector{i,2}(1));
    if vector{i,1}(1)>0 && vector{i,1}(2)>0
        plot(vector{i,1},vector{i,2});
       % plot(vector{i,1}(1),vector{i,2}(1),'*');
    %plot(vector{i,:},vector{i,:});
    % plot(vector{i,1}(2),vector{i,1}(1));
    end
end

hold off;

end