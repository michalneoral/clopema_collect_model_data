function [ vector ] = fromFlowToVector( flow )

index=1;

    for i=1:size(flow,1)
        for j=1:size(flow,2)
            if(flow(i,j,1)~=0 && flow(i,j,2)~=0)
                vector(index,1)={[j,j+flow(i,j,1)]};
                vector(index,2)={[i,i+flow(i,j,2)]};
                index=index+1;
            end
        end
    end
end