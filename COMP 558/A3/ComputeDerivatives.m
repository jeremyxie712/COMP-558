function [fx,fy,ft] = ComputeDerivatives(im1,im2)

fx = conv2(im1,0.25*[-1 1; -1 1]) + conv2(im2,0.25*[-1 1; -1 1]);
fy = conv2(im1,0.25*[-1 -1; 1 1]) + conv2(im2,0.25*[-1 -1; 1 1]);
ft = conv2(im1,0.25*ones(2)) + conv2(im2,-0.25*ones(2));

% [fx,fy] = gradient(im1);
% ft = im2 - im1;

%Adjusting to the same size as the input% 
fx=fx(1:size(fx,1)-1, 1:size(fx,2)-1);
fy=fy(1:size(fy,1)-1, 1:size(fy,2)-1);
ft=ft(1:size(ft,1)-1, 1:size(ft,2)-1);
end