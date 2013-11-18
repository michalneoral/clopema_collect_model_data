function [] = multiplayerSubplot(size,i,order,image,msgs, main_order, main_image)
    subplot(1,size,i);
    time=getTimeOfImage( msgs, order, image )-getTimeOfImage( msgs, main_order, main_image );
    subtitle=sprintf('%s (%.5f)',msgs{order,3}{1,1},time);    
    multiplayerRecognizeAndPlay(order,image,msgs);
    title(subtitle);
end