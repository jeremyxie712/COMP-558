function new_img = images()
img = zeros(400,500);
% Now we draw the rectangles inside the image
img(200:300,140:280) = 115;
img(300:320,200:240) = 125;
img(100:210,70:90) = 119;

% figure,imshow(img,[]);

% Now we draw the circle inside the image 
imageSizeX = 400;
imageSizeY = 500;
[columnsInImage,rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = 320;
centerY = 240;
radius = 60;
circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;



% imshow(circlePixels,[]);
% colormap([0 0 0; 1 1 1]);

% Now we imfuse two images to one
 newImg = imfuse(img,circlePixels);
 new_img = rgb2gray(newImg);
% new_img = img + circlePixels;
% imshow(new_img,[]);
end