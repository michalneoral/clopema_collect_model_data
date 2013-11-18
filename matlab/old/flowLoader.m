flow = callOptFarneback(im1f,im2f);
% a=(abs(flow)>3);
% b=(abs(flow)<75);
% flow2=b.*a.*flow;
flow2=flow;
vector=fromFlowToVector(flow2);
figure(1)
image(im1f)
plotVectors(vector);
figure(2)
image(im2f)
plotVectors(vector);