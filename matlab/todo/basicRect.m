function [ x,y ] = basicRect( x,y,P )

    UVW=P*[x;y;1;1];
    x=UVW(1)/UVW(3);
    y=UVW(2)/UVW(3);

end

