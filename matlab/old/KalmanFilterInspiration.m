clc
clear all
close all
file=aviinfo('video.avi');
nFrames=file.NumFrames;
rows=file.Height;
cols=file.Width;
video=aviread('video.avi');
%     outfile = input('Enter the movie name: ','s');
    aviobj =avifile('kalman.avi','Compression','None','fps',15);
    a=[1 0 1 0;0 1 0 1;0 0 1 0;0 0 0 1];	%state model matrix
    h=[1 0 0 0;0 1 0 0];	%observation model matrix
    q=[5 0 0 0;0 5 0 0;0 0 1 0;0 0 0 1];	%Noise
    r=[5 0;0 5];
    unitary=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
for k = 1 : nFrames
    frame=video(k);
    framedata=frame.cdata;
    data=rgb2gray(framedata);
    data1=im2bw(data);
    % calculation of center of ball;
    min_x=rows;
    max_x=0;
    min_y=cols;
    max_y=0;
    for i = 1 : rows
        for j = 1 : cols
            if (data1(i,j)==0)
                if(i<min_x)
                min_x= i;
                end;
                if(i>max_x)
                max_x= i;
                end;
                if(j<min_y)
                min_y= j;
                end;
                if(j>max_y)
                max_y= j;
                end;
            end;
        end
    end
    currx= (min_x+max_x)/2;
    curry= (min_y+max_y)/2;
    % initialization for first frame;
    if (k==1)
        prevx=currx;
        prevy=curry;
        estx=currx+30;		%didn't get this 
        esty=curry-30;		%didn't get this
        estvx=0;
        estvy=0;
        xest=[estx;esty;estvx;estvy];
        p=[10 0 0 0;0 10 0 0;0 0 10 0;0 0 0 10];
    end; % end of initialization
    vx= currx-prevx;
    vy=curry-prevy;
    xactual=[currx;curry;vx;vy];
    yactual=h*xactual;
    yest=h*xest;% here rectangle will be placed
    % code for tracking rectangle
    x=yest(1,1);
    y=yest(2,1);
    for i = 1 : rows
        for j = 1 : cols
            if ((i>=x-3)&&(i<=x+3)&&(j>=y-3)&&(j<=y+3))
            framedata(i,j,1)=1;
            framedata(i,j,2)=1;
            end;
        end
    end
    xestnext=a*xest;	%first Kalman Equation
    xactualnext=a*xactual;
    ydesirednext=h*xactualnext;
    pnext=(a*p*a')+q;	%second Kalman Equation
    kalman_gain=(pnext*h')/((h*pnext*h')+r);	%fourth kalman equation (kalman gain)
    xupdate=xestnext + kalman_gain*(ydesirednext - (h*xestnext));	%third kalman equation
    pupdate=(unitary - (kalman_gain*h))*pnext; 	%fifth kalman equation
    % parameters update for next iteration
    xest=xupdate;
    p=pupdate;
    prevx=currx;
    prevy=curry;% parameters update complete
    imshow(framedata);
    hold on;
imi = getframe(gca);
aviobj = addframe(aviobj,imi);
end
aviobj = close(aviobj);