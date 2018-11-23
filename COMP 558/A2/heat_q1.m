function [im_heat] = heat_q1(image,deltaT,t,sigma)
img = imread(image);
img_red = img(:,:,1);
img_gre = img(:,:,2);
img_blu = img(:,:,3);

img_filtered = imgaussfilt(img_gre,sigma);
img_filtered = im2double(img_filtered);
%img_filtered = double(img_filtered);
figure(1),imshow(img_filtered);title('Gaussian filtered image');
iteration = t/deltaT;
im_heat = img_gre;
for i=1:iteration
%     im_heat = (centralDiffX(centralDiffX(im_heat))+centralDiffY(centralDiffY(im_heat)))*deltaT+double(im_heat);
    [Fx,Fy] = gradient(double(im_heat));
    [Fxx,Fxy] = gradient(Fx);
    [Fyx,Fyy] = gradient(Fy);
    im_heat = (Fxx + Fyy) * deltaT + double(im_heat);
    figure(2),imshow(uint8(im_heat));
end
title('Heat diffused image');
im_heat = im2double(im_heat);

figure(3),imshow(img_filtered - im_heat);title('Discrepancy');
end