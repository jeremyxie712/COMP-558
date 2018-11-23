function cdiffimgY = centralDiffY(img)
img_gre = img;
padImgY = [img_gre(1,:); img_gre ; img_gre(size(img_gre,1),:)];
cdiffimgY = zeros(size(img_gre));
[rowY,colY] = size(img_gre);

for m=2:rowY+1
    for n=1:colY
        cdiffimgY(m-1,n) = (padImgY(m+1,n)-(padImgY(m-1,n)))/2;
    end
end
end