function [q4_output] = Q4()
clc;
close all;

im1 = imread('c1.JPG');
theta = deg2rad(10); %Here we set the degree, beware that trig commands take radians instead of degrees.

%Here we compute the mx and my which are useful when it comes to multiply
%the focal length
mx = size(im1,2)/23.6;
my = size(im1,1)/15.8;

%We construct the R1 to be an identity matrix and then K1, K2 and R2. 
R1 = eye(3);
K1 = [ 50*mx 0 size(im1,2)/2; 
       0 50*my size(im1,1)/2; 
       0     0           1 ]; 
K2 = [ 25*mx/2 0 size(im1,2)/4; 
       0 25*my/2 size(im1,1)/4; 
       0       0           1 ];
R2 = [cos(theta) 0 sin(theta);0 1 0;-sin(theta) 0 cos(theta)];


H = (K2*R2)*inv(K1*R1); %Homography matrix
[row,col] = size(im1(:,:,1));
im2 = zeros(row/2,col/2,3); %Initialize it to be half of the size on x and y direction 

for i = 1:row
    for j = 1:col
        im2coord = H * [j;i;1];
        wx = round(im2coord(1)/im2coord(3));
        wy = round(im2coord(2)/im2coord(3));
        
        if  wx > row || wx < 1 || wy > col || wy < 1
            im2(wy,wx,1) = 0;
            im2(wy,wx,2) = 0;
            im2(wy,wx,3) = 0;
        else
            im2(wy,wx,1) = im1(i,j,1);
            im2(wy,wx,2) = im1(i,j,2);
            im2(wy,wx,3) = im1(i,j,3);
        end
    end
end


%Display the image with axis
imagesc(uint8(im2));


end