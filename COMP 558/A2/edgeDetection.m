function [im_out,grad_orient] = edgeDetection(img,img_threshold)
I = imread(img);
I = double(I);
test_img = imresize(I,1);


redImg = test_img(:,:,1); %Take the red channel 
greImg = test_img(:,:,2); %Take the green channel 
bluImg = test_img(:,:,3); %Take the blue channel 

h = fspecial('gaussian',[5 5],1);
filtered_img = conv2(greImg,h);

image_pad = padarray(filtered_img,[1 1],0,'both');
[rows,cols] = size(image_pad);
hor_new_img = zeros(rows,cols);
ver_new_img = zeros(rows,cols);

%Now we compute x direction 
for i=1:rows
    for j=2:cols-1
        hor_new_img(i,j) = (1/2).*image_pad(i,j+1)-(1/2).*image_pad(i,j-1);
    end
end

%Now we compute y direction 
for i=2:rows-1
    for j=1:cols
        ver_new_img(i,j) = (1/2).*image_pad(i+1,j)-(1/2).*image_pad(i-1,j);
    end
end

% figure;imshow(hor_new_img,[]);title('Horizontal');
% figure;imshow(ver_new_img,[]);title('Vertical');

%Now we compute gradient magnitude 
grad_mag = zeros(rows,cols);
for i=1:rows
    for j=2:cols-1
        grad_mag(i,j) = (1/2)*sqrt((hor_new_img(i,j)^2)+(ver_new_img(i,j)^2));
    end
end


%Now we compute the gradient orientation
grad_orient = zeros(rows,cols);
for i=1:rows
    for j=2:cols-1
        grad_orient(i,j) = atan(ver_new_img(i,j)/hor_new_img(i,j));
    end
end

img_threshold = 2.34;
%Now we mark the edges once they exceed the threshold
img_threshold_use = im2double(image_pad);
[sRows,sCols] = size(img_threshold_use);
binaryImage = zeros(sRows,sCols);
for i=1:rows
    for j=2:cols-1
        if grad_mag(i,j) > img_threshold
            binaryImage(i,j)=1;
        else
            binaryImage(i,j)=0;
        end
    end
end


%subplot(2,2,3);
%figure;imshow(binaryImage,[]);title('Binary Image');
im_out = binaryImage;
%imshow(im_out,[]);
end