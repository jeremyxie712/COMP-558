function im_result = zerocrossing(sigma)

new_img = images();
[new_rows,new_cols] = size(new_img);
% [frows,fcols] = size(filter_size);
Log_filter = zeros(15,15);
%  new_r = floor(frows/2);
%  new_c = floor(fcols/2);
% figure,
% imshow(new_img);title('original img');

%sigma = 1;
for i=-7:7
    for j=-7:7
        %Log_filter(i+2,j+2) = ((-1)/(pi*sigma*sigma*sigma*sigma))*(1-((i*i+j*j)/(2*sigma*sigma)))*(exp(((-1)*(i*i+j*j))/(2*sigma*sigma)));
        Log_filter(i+8,j+8)=(-1/pi*sigma^4)*(1-((i^2+j^2)/(2*sigma^2)))*(exp(-(i^2+j^2)/(2*sigma^2)));
    end
end
%surf(Log_filter);
%Log_filter = Log_filter / sum(Log_filter(:));         

log_conv = conv2(double(new_img),Log_filter);

% figure,
%  imshow(log_conv+0.5);title('image right after convolution');
 
[sRows,sCols] = size(log_conv); 
binaryEdge = zeros(sRows,sCols);

for i=2:new_rows-1
    for j=2:new_cols-1
        if(log_conv(i+1,j)*log_conv(i-1,j)<0)||(log_conv(i,j-1)*log_conv(i,j+1)<0)||(log_conv(i-1,j-1)*log_conv(i+1,j+1)<0)||(log_conv(i+1,j-1)*log_conv(i-1,j+1)<0)
            binaryEdge(i,j) = 1;
        end
    end
end
im_result = binaryEdge;
% figure,
% imshow(im_result,[]);title('binary image');
end