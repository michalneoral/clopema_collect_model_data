function [imageMoravec] = moravec(imageMono)

% function to detect important points

res=size(imageMono);
imageMoravec=nan(res);
        for i=2:res(1)-1 % Y
            for j=2:res(2)-1 % X
                                suma=0;
                                for k=i-1:i+1
                                    for e=j-1:j+1
                                        suma=suma+abs(imageMono(k,e)-imageMono(i,j));
                                    end
                                end
%                 imageMoravec(i,j) = 1/8 * abs(sum(sum(imageMono(i-1:i+1,j-1:j+1)))-8*imageMono(i,j));
                                imageMoravec(i,j) = 1/8 * suma;
            end
        end
    maximum=max(max(imageMoravec));
    imageMoravec=imageMoravec(:,:)./(maximum+0.000000001);
end