function [] = multiplayerRecognizeAndPlay(order,image,msgs)
    if strcmp(msgs{order,3}, '/xtion1/depth/image_raw') || strcmp(msgs{order,3}, '/xtion1/depth_registered/image_raw') || strcmp(msgs{order,3}, '/xtion1/depth/image_rect_raw')
        [ pcloud, distance ] = getCloud( msgs{order, 1}{1, image}.data, true);
        surf(distance,'EdgeColor','none');
        %surf(pcloud(:,:,1),pcloud(:,:,2),pcloud(:,:,3),'EdgeColor','none');
        view(0,-90);
        rotate3d on;
    
    elseif strcmp(msgs{order,3}, '/xtion1/rgb/image_raw') || strcmp(msgs{order,3}, '/xtion1/rgb/image_rect_color')
        doRGB(msgs{order, 1}{1, image}.data);        
    
    else
        disp('Bad topic to this script'); 
    end
end
