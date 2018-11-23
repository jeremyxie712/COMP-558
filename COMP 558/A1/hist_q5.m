function im_hist = hist_q5()
I = imread('noodle.jpeg');
I = double(I);
test_img = imresize(I,0.33);

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
subplot 321,bar(normalized_ver);title('Vertical axis after normalization');
subplot 322,histogram(ver_new_img(:),255);title('Regular vertical axis');
subplot 323,bar(log(normalized_ver));title('Log of vertical axis after normalization');


end