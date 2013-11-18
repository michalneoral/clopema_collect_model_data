function [ something ] = showSubPlotWithPoints( msgs, queue, nfile, rgb_back )
something = 0;

topic3d=1;
topicrgb=2;

y_s = 2;
x_s = 3;

res_Y=480;
res_X=640;

hFig = figure(1);
set(hFig, 'Position', [50 50 1200 600])

%% Plotting 3D

[ pcloud, distance ] = getCloud( msgs{queue{nfile,1}(topic3d,3),1}{1,queue{nfile,1}(topic3d,1)}.data , true);

subplot(y_s,x_s,4);
surf(distance,'EdgeColor','none');
view(0,-90);
rotate3d off;
colormap(jet);
grid on;

%% Plotting Image Color

subplot(y_s,x_s,1);
preImage = queueToImage(msgs{queue{nfile,1}(topicrgb,3),1}{1,queue{nfile,1}(topicrgb,1)}.data,res_X,res_Y);
imageRGB = normalizeRGB (preImage);
image(imageRGB);
grid on;

% %% Plotting 3D 2
% 
% [ pcloud, distance ] = getCloud( msgs{queue{nfile+1,1}(1,3),1}{1,queue{nfile+1,1}(1,1)}.data , true);
% 
% subplot(y_s,x_s,3);
% surf(distance,'EdgeColor','none');
% view(0,-90);
% rotate3d off;
% 
% %% Plotting Image Color 2
% 
% subplot(y_s,x_s,4);
% preImage = queueToImage(msgs{queue{nfile+1,1}(2,3),1}{1,queue{nfile+1,1}(2,1)}.data,res_X,res_Y);
% imageRGB = normalizeRGB (preImage);
% image(imageRGB);

%% Plot masked

% imageMasked=nan(size(imageRGB,1),size(imageRGB,2));
subplot(y_s,x_s,2);
% for i=1:res_Y
%     for j=1:res_X
%         %if ~isnan(distance(i,j))
%             imageMasked(i,j)=imageRGB(i,j,1)*0.6+imageRGB(i,j,2)*0.3+imageRGB(i,j,3)*0.1;
%         %end
%     end
% end
% image(imageMasked);

imageFiltred = motionDetection(imageRGB, rgb_back);
image(imageFiltred);
grid on;

%% Plot Moravec

imageMono(:,:)=imageFiltred(:,:,1)*0.6+imageFiltred(:,:,2)*0.3+imageFiltred(:,:,3)*0.1;
imageMoravec=moravec(imageMono);

subplot(y_s,x_s,3);
%getCouplesOfPoints(imageMoravec,imageMoravec);

imagemor=zeros(size(imageMoravec,1),size(imageMoravec,2),3);
for i=1:3
imagemor(:,:,i)=imageMoravec(:,:);
end

image(imagemor);
something=imageMoravec;
grid on;

%% Second image

subplot(y_s,x_s,5);
preImage2 = queueToImage(msgs{queue{nfile+1,1}(topicrgb,3),1}{1,queue{nfile+1,1}(topicrgb,1)}.data,res_X,res_Y);
imageRGB2 = normalizeRGB (preImage2);
imageFiltred2 = motionDetection(imageRGB2, rgb_back);
image(imageFiltred2);
grid on;

% subplot(y_s,x_s,5);
% imageFiltred(:,:,1) = highlightPoints(imageFiltred(:,:,1), [100, 200]);
% image(imageFiltred);

%% Plot Moravec second image

subplot(y_s,x_s,6);
imageMono2(:,:)=imageFiltred2(:,:,1)*0.6+imageFiltred2(:,:,2)*0.3+imageFiltred2(:,:,3)*0.1;
imageMoravec2=moravec(imageMono2);

imagemor2=zeros(size(imageMoravec2,1),size(imageMoravec2,2),3);
for i=1:3
imagemor2(:,:,i)=imageMoravec2(:,:);
end

image(imagemor2);
grid on;

%% Two images

hFig2 = figure(2);
set(hFig2, 'Position', [50 50 1200 500]);

subplot(1,2,1);
%imageHighlighted=highlightPoints(imageFiltred, [163 345]);
%image(imageHighlighted(125:225,300:400,:));
image(imageFiltred);
grid on;

% Load second image
subplot(1,2,2);
% imageHighlighted2=highlightPoints(imageFiltred2, [300 300]);
% image(imageHighlighted2(125:225,300:400,:));
subplot(y_s,x_s,4);
surf(distance,'EdgeColor','none');
view(0,-90);
rotate3d off;
colormap(jet);
grid on;

something = cv.calcOpticalFlowFarneback(rgb2gray(imageFiltred), rgb2gray(imageFiltred2));

%% Splited Images

[splited_images,cx,cy] = splitImage(imageFiltred);
%  hFig2 = figure(3);
%  set(hFig2, 'Position', [50 50 1200 600]);
% for i=1:size(splited_images,1)
%     subplot(cy,cx,i);
%     imshow(splited_images{i,1});
% end
% 
[splited_images2,cx,cy] = splitImage(imageFiltred2);
% hFig2 = figure(4);
% set(hFig2, 'Position', [50 50 1200 600]);
% for i=1:size(splited_images2,1)
%     subplot(cy,cx,i);
%     imshow(splited_images2{i,1});
% end

figure(5)
I = rgb2gray(imageFiltred);
regionsObj = detectMSERFeatures(I);
[features, validPtsObj] = extractFeatures(I, regionsObj);
imshow(I); hold on;
plot(validPtsObj,'showOrientation',true);

figure(6)
I = rgb2gray(imageFiltred2);
regionsObj = detectMSERFeatures(I);
[features, validPtsObj] = extractFeatures(I, regionsObj);
imshow(I); hold on;
plot(validPtsObj,'showOrientation',true);
end

function [imagesStruct, cx, cy] = splitImage(Image, resolution, segmentation, right_border, down_border)
    if nargin < 2
        resolution = 150;
    end
    if nargin < 3
        segmentation = 75;
    end
    if nargin < 5
        if nargin == 4
            disp ('must be put down border too (otherwise is set)')
        end
        right_border = round(mod(size(Image,2),segmentation)/2);
        down_border = round(mod(size(Image,1),segmentation)/2);
    end
    cy=0;
    index=1;
    cp_y = down_border;    
    while cp_y <= size(Image,1)-(right_border+resolution-1)
        cp_x = right_border;
        while cp_x <= size(Image,2)-(down_border+resolution-1)
            im=Image(cp_y:(cp_y+resolution),cp_x:(cp_x+resolution),:);
            imagesStruct(index,:)={im};
            cp_x=cp_x+segmentation;
            index=index+1;
        end
        cp_y=cp_y+segmentation;
        cy=cy+1;
    end    
    cx=(index-1)/cy;
end

function [image] = highlightPoints(image, points)
    for i=1:size(points,1)
        image = MidpointCircle(image, 10, points(i,1), points(i,2), 1);
    end
end

function [reduceMoravec] = reduceMoravec(moravecImg)
    reduceMoravec=moravecImg;
    min = 0.3;
    for i=1:size(moravecImg,1)
        for j=1:size(moravecImg,2)
            if max(moravecImg(i,j,:) < min)
                reduceMoravec(i,j,:)=NaN;
            end
        end
    end    
end

function [mask] = getMask(radius)
    
end