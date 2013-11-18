function [ chainP ] = chainOfPoints( startPoints, optFlow )
    chainP=cell(size(startPoints,1),size(optFlow,2));
    for i = 1:size(startPoints,1)
         chainP(i,:)= getChain(startPoints{i,1}, optFlow);
    end    
end

function [ chain ] = getChain( startPoint, optFlow )
    chain=cell(size(optFlow,2),1);
    chain(1) = {startPoint};
    for i=2:size(optFlow,2)
        chain(i) = {getNextPoint(chain(i-1), optFlow, i)};
    end
end

function [ nextPoint ] = getNextPoint(lastPoint, flow, number)
    nextPoint = [flow{1,number}(lastPoint{1,1}(1),lastPoint{1,1}(2),1) + lastPoint{1,1}(1),flow{1,number}(lastPoint{1,1}(1),lastPoint{1,1}(2),2) + lastPoint{1,1}(2)];
end