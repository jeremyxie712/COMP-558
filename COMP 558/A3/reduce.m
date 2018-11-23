function smallIm = reduce(im,win)

%The reduce method are built for constructing gaussian pyramid, it builds
%pyramid using our arbitrary window size. 
mask = fspecial('gaussian',win,floor(win / 6));

hResult = imfilter(im,mask);
hResult = hResult(:,3:size(hResult,2)-2);
hResult = hResult(:, 1:2:size(hResult,2));

vResult = conv2(hResult, mask');
vResult = vResult(3:size(vResult,1)-2, :);
vResult = vResult(1:2:size(vResult,1),:);

smallIm = vResult;
end