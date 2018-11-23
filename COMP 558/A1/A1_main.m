function homework1 = A1_main()
clc;
close all;


%%%Question1%%%
%-------------%
g = make2Dgaussian(30, 15);
img = imread('bayern.jpg');
grimg = rgb2gray(img);
im = myConv2(grimg,g);
figure,
subplot 131, imshow(grimg); title('Grayscale Image')
subplot 132, surf(g); title('Gaussian Filter')
subplot 133, imshow(im); title('Gaussian Filtered Image')
%-------------%


%%%Question2%%%
%-------------%
im_out = edgeDetection('noodle.jpeg',2.34);
figure,
imshow(im_out,[]);

%%%Question3%%%
%-------------%
im_result = zerocrossing(0.5);
figure,
imshow(im_result,[]);title('Binary image');
%-------------%

%%%Quesstion4%%%
%The code is below%
%--------------%
img_one = imread('noodle.jpeg');
img_two = images();

temp_img = imresize(img_one,0.33);
gray_temp = rgb2gray(temp_img);
I2 = imcrop(gray_temp,[250 250 20 20]);
axis on;

I3 = imcrop(img_two,[250 250 20 20]);
axis on;

I4 = edgeDetection('noodle.jpeg',2.34);
I5 = zerocrossing(0.55);

crop_edge_2 = imcrop(I4,[250 250 20 20]);
crop_edge_3 = imcrop(I5,[250 250 20 20]);

figure,
subplot 321,imshow(I2,[]);title('image from question 2 after initial crop');
subplot 322,imshow(I3,[]);title('image from question 3 after initial crop');
subplot 323,imshow(crop_edge_2,[]);title('image from question 2 after edge detection');
subplot 324,imshow(crop_edge_3,[]);title('image from question 3 after edge detection');

[nr,nc]=size(I2);
[dx,dy] = gradient(double(I2));
[x,y] = meshgrid(1:nc,1:nr);
u = dx;
v = dy;
figure,
subplot 121,imshow(I2);title('gradient vector field over image from q2');
hold on;
quiver(x,y,u,v);
hold off;


[mr,mc]=size(I3);
[rx,ry] = gradient(double(I3));
[a,b] = meshgrid(1:mc,1:mr);
ku = rx;
kv = ry;
subplot 122,imshow(I3);title('gradient vector field over image from q3');
hold on;
quiver(a,b,ku,kv)
hold off;


%%%Question5%%%
%The code is below%
%-------------%
I = imread('noodle.jpeg');
I = double(I);
test_img = imresize(I,0.33);

redImg = test_img(:,:,1); %Take the red channel 
greImg = test_img(:,:,2); %Take the green channel 
bluImg = test_img(:,:,3); %Take the blue channel 

h = fspecial('gaussian',[5 5],100);
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


% Changing the horizontal axis 
temp_hor = hist(hor_new_img(:),255);
normalized_hor = temp_hor./numel(hor_new_img);
% Changing the vertical axis
temp_ver = hist(ver_new_img(:),255);
normalized_ver = temp_ver./numel(ver_new_img);


% Now we plot them out
figure,
subplot 221,histogram(hor_new_img(:),255);title('Regular horizontal axis');
subplot 222,bar(normalized_hor);title('Hortizontal axis after normalization');
subplot 223,bar(log(normalized_hor));title('Log of hortizontal axis after normalization');
figure,
subplot 321,histogram(ver_new_img(:),255);title('Regular vertical axis');
subplot 322,bar(normalized_ver);title('Vertical axis after normalization');
subplot 323,bar(log(normalized_ver));title('Log of vertical axis after normalization');

end