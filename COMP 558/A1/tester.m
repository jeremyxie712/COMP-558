function im_test = tester()
new_img = images();
[new_rows,new_cols] = size(new_img);
%[frows,fcols] = size(filter_size);
Log_filter = zeros(31,31);
% new_r = floor(frows / 2);
% new_c = floor(fcols / 2);

sigma = 1.0;
for i=-15:15
    for j=-15:15
        Log_filter(i+16,j+16) = ((-1)/(pi*sigma*sigma*sigma*sigma))*(1-((i*i+j*j)/(2*sigma*sigma)))*(exp(((-1)*(i*i+j*j))/(2*sigma*sigma)));  
    end
end
%Log_filter = Log_filter / sum(Log_filter(:));
surf(Log_filter);title('My filter');
L_filter = fspecial('log', [31,31], 1.0); % fspecial creat predefined filter.Return a filter.
                                          % 25X25 Gaussian filter with SD =25 is created.
 figure,                                         
 surf(L_filter);title('fspecial filter');
 
 
 
 
 
 
 sum1=0;
for i=1:length(A)
  sum1=sum1+A(i);
end
M=sum1/length(A); %the mean
sum2=0;
for i=1:length(A)
    sum2=sum2+ (A(i)-M)^2;
end
V=sum2/length(A); %Varaince
end