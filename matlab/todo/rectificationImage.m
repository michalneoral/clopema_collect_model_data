function [ rect_image ] = rectificationImage( rect, image )

 % DODELAT

    rect_image=zeros(size(image));
    
    K=rect.K;
    R=rect.R;
    D=rect.D;
    P=rect.P;    
   
    
     for i=1:size(image,1)
         for j=1:size(image,2)
             for k=1:size(image,3)
                 
             end
         end
     end

     rect_image=sec_image;
     
end

