function cdiffimgX = centralDiffX(img)
img_gre = img;
padImgX = [ img_gre(:,1) img_gre img_gre(:,size(img_gre,2))];
cdiffimgX = zeros(size(img_gre));
[rowX,colX] = size(img_gre);

for i=1:rowX
    for j=2:colX+1
        cdiffimgX(i,j-1) = (padImgX(i,j+1)-(padImgX(i,j-1)))/2;
    end
end
end