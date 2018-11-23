function largeIm = expand(im,window)

mask = fspecial('gaussian',window,floor(window / 6));

% insert zeros in every alternate position in each row
rowZeros = [im; zeros(size(im))];
rowZeros = reshape(rowZeros, size(im,1), 2*size(im,2));

%conv with horiz mask
newIm = conv2(rowZeros, mask);
newIm = newIm(:,3:size(newIm,2)-2);

% insert zeros in every alternate position in each col
colZeros = newIm';
colZeros = [colZeros; zeros(size(colZeros))];
colZeros = reshape(colZeros, size(colZeros,1)/2, 2*size(colZeros,2));
colZeros = colZeros';

largeIm=conv2(colZeros, mask');
largeIm=largeIm(3:size(largeIm,1)-2,:);
end