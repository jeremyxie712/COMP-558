function im_comparison = comparison_gradedge(img_question2)
img_one = imread(img_question2);
img_two = images();

temp_img = imresize(img_one,0.33);
gray_temp = rgb2gray(temp_img);
I2 = imcrop(gray_temp,[250 250 20 20]);
axis on;

I3 = imcrop(img_two,[250 250 20 20]);
axis on;

I4 = edgeDetection('noodle.jpeg',2.34);
I5 = zerocrossing([3 3],1);

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


end