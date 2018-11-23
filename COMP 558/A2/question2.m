function im_out = question2(img)
I = imread('james.jpg');

img_blu = I(:,:,3);
img_blu = im2double(img_blu);

%-------------------------------------------------------------------------%
%Now we generate the Gaussian pyramid%

G1 = fspecial('gaussian',[3 3],1);
G2 = fspecial('gaussian',[3 3],2);
G4 = fspecial('gaussian',[3 3],4);
G8 = fspecial('gaussian',[3 3],8);
G16 = fspecial('gaussian',[3 3],16);
G32 = fspecial('gaussian',[3 3],32);

%Gaussian level 0%
ig_gau_temp = img_blu;
ig_one = conv2(ig_gau_temp,G1,'same');

%Gaussian level 1%
ig_gau_two = ig_one;
ig_two = conv2(ig_gau_two,G2,'same');
ig_two = imresize(ig_two,0.5);

%Gaussian level 2%
ig_gau_three = ig_two;
ig_three = conv2(ig_gau_three,G4,'same');
ig_three = imresize(ig_three,0.5);

%Gaussian level 3%
ig_gau_four = ig_three;
ig_four = conv2(ig_gau_four,G8,'same');
ig_four = imresize(ig_four,0.5);

%Guassian level 4%
ig_gau_five = ig_four;
ig_five = conv2(ig_gau_five,G16,'same');
ig_five = imresize(ig_five,0.5);

%Gaussian level 5%
ig_gau_six = ig_five;
ig_six = conv2(ig_gau_six,G32,'same');
ig_six = imresize(ig_six,0.5);

%Gaussian printing statements%
% figure,imshow(ig_one,[]);
% figure,imshow(ig_two,[]);
% figure,imshow(ig_three,[]);
% figure,imshow(ig_four,[]);
% figure,imshow(ig_five,[]);
% figure,imshow(ig_six,[]);

%-------------------------------------------------------------------------%
%Now we generate the Laplacian pyramid%

%Laplacian level 5%
ig_lap_one = ig_six;

%Laplacian level 4%
ig_lap_two = ig_six;
ig_eight = imresize(ig_lap_two,2);
ig_eight = conv2(ig_eight,G16,'same');
[pad9 pad] = size(ig_eight);
[pad10 pad] = size(ig_five);
if pad9 ~= pad10
    ig_five = padarray(ig_five,[abs(pad10 - pad9) abs(pad10 - pad9)],'replicate','post');
end
ig_eight = ig_eight- ig_five;

%Laplacian level 3%
ig_lap_three = ig_five;
ig_nine = imresize(ig_lap_three,2);
ig_nine = conv2(ig_nine,G8,'same');
[pad7 pad] = size(ig_nine);
[pad8 pad] = size(ig_four);
if pad7 ~= pad8
    ig_four = padarray(ig_four,[abs(pad8 - pad7) abs(pad8 - pad7)],'replicate','post');
end
ig_nine = ig_nine - ig_four;

%Laplacian level 2%
ig_lap_four = ig_four;
ig_ten = imresize(ig_lap_four,2);
ig_ten = conv2(ig_ten,G4,'same');
[pad5 pad] = size(ig_ten);
[pad6 pad] = size(ig_three);
if pad5 ~= pad6
    ig_three = padarray(ig_three,[abs(pad6 - pad5) abs(pad6 - pad5)],'replicate','post');
end
ig_ten = ig_ten - ig_three;

%Laplacian level 1%
ig_lap_five = ig_three;
ig_eleven = imresize(ig_lap_five,2);
ig_eleven = conv2(ig_eleven,G2,'same');
[pad1 pad] = size(ig_eleven);
[pad2 pad] = size(ig_two);
if pad1 ~= pad2
    ig_two = padarray(ig_two,[abs(pad2 - pad1) abs(pad2 - pad1)],'replicate','post');
end
ig_eleven = ig_eleven - ig_two;

%Laplacian level 0%
ig_lap_six = ig_two;
ig_twelve = imresize(ig_lap_six,2);
ig_twelve = conv2(ig_twelve,G1,'same');
[pad3 pad] = size(ig_twelve);
[pad4 pad] = size(ig_one);
if pad3 ~= pad4
    ig_one = padarray(ig_one,[abs(pad4 - pad3) abs(pad4 - pad3)],'replicate','post');
end
ig_twelve = ig_twelve - ig_one;


%Laplacian printing statements%
% figure,imshow(ig_lap_one,[]);
% figure,imshow(ig_eight,[]);
% figure,imshow(ig_nine,[]);
% figure,imshow(ig_ten,[]);
% figure,imshow(ig_eleven,[]);
% figure,imshow(ig_twelve,[]);

%-------------------------------------------------------------------------%
%Part three%
sigma = 4;
filt_log = fspecial('log',[23 23],sigma);
filt_gau_one = fspecial('gaussian',[23 23],sigma);
filt_gau_two = fspecial('gaussian',[23 23],3*sigma);

DoG = filt_gau_two - filt_gau_one;

filt_log_one = fspecial('log',[25 25],11);
filt_gau_three = fspecial('gaussian',[25 25],11);
filt_gau_four = fspecial('gaussian',[25 25],21);

DoG_two = filt_gau_four - filt_gau_three;

% figure,
% subplot 321, surf(2 * filt_log); title('LoG with sigma = 4');
% subplot 322, surf(DoG); title('DoG with sigma = 4 and k = 3');
% 
% subplot 323, surf(10 * filt_log_one); title('LoG with sigma = 11');
% subplot 324, surf(DoG_two); title('DoG with sigma = 11 and k = 10');


%-------------------------------------------------------------------------%
%Part four%
kp1 = sift(ig_ten,ig_eleven,ig_twelve,2);
kp2 = sift(ig_nine,ig_ten,ig_eleven,4);
kp3 = sift(ig_eight,ig_nine,ig_ten,8);
kp4 = sift(ig_lap_one,ig_eight,ig_nine,16);
im_out = img;
figure,
imshow(im_out,[]);
hold on;

% Next create the circle in the image. We plot circles over 4 levels of the
% Laplacian pyramid. 

for i = 1:length(kp1)
    plot(2 * kp1{i}{1}{1},2 * kp1{i}{1}{2},'o','MarkerSize',2);
end

for i= 1:length(kp2)
    plot(4 * kp2{i}{1}{1},4 * kp2{i}{1}{2},'o','MarkerSize',4);
end

for i = 1:length(kp3)
    plot(8 * kp3{i}{1}{1},8 * kp3{i}{1}{2},'o','MarkerSize',8);
end

for i = 1:length(kp4)
    plot(16 * kp4{i}{1}{1},16 * kp4{i}{1}{2},'o','MarkerSize',16);
end

end