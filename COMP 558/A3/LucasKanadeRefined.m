function [u,v,cert] = LucasKanadeRefined(uIn,vIn,im1,im2,win)
 
%[fx, fy, ft] = ComputeDerivatives(im1, im2);
 
uIn = round(uIn);
vIn = round(vIn);
hw = floor(win / 2);
%uIn = uIn(2:size(uIn,1), 2:size(uIn, 2)-1);
%vIn = vIn(2:size(vIn,1), 2:size(vIn, 2)-1);
 
G = fspecial('gaussian',[15 15],15);
 
u = zeros(size(im1));
v = zeros(size(im2));
 
for i = 1+hw:size(im1,1)-hw
   for j = 1+hw:size(im1,2)-hw
      
      curIm1 = im1(i-hw:i+hw, j-hw:j+hw);
      lowRindex = i-hw+vIn(i,j);
      highRindex = i+hw+vIn(i,j);
      lowCindex = j-hw+uIn(i,j);
      highCindex = j+hw+uIn(i,j);
      
%       if (lowRindex < 1) 
%          lowRindex = 1;
%          highRindex = hw;
%       end
%       
%       if (highRindex > size(im1,1))
%          lowRindex = size(im1,1)-hw;
%          highRindex = size(im1,1);
%       end
%       
%       if (lowCindex < 1) 
%          lowCindex = 1;
%          highCindex = hw;
%       end
%       
%       if (highCindex > size(im1,2))
%          lowCindex = size(im1,2)-hw;
%          highCindex = size(im1,2);
%       end
      
%       if isnan(lowRindex)
%          lowRindex = i-2;
%          highRindex = i+2;
%       end
%       
%       if isnan(lowCindex)
%          lowCindex = j-2;
%          highCindex = j+2;
%       end
      if(lowRindex < 1)||(highRindex > size(im1,1))||(lowCindex < 1)||(highCindex > size(im1,2))
      else
      curIm2 = im2(lowRindex:highRindex, lowCindex:highCindex);
      
      curIm1 = conv2(curIm1,G);
      curIm2 = conv2(curIm2,G);
      
      [curFx, curFy, curFt]=ComputeDerivatives(curIm1, curIm2);
      curFx = curFx(2:win-1, 2:win-1);
      curFy = curFy(2:win-1, 2:win-1);
      curFt = curFt(2:win-1, 2:win-1);
      
      curFx = curFx';
      curFy = curFy';
      curFt = curFt';
 
 
      curFx = curFx(:);
      curFy = curFy(:);
      curFt = -curFt(:);
 
      A = [curFx curFy];
         
      U = pinv(A'*A)*A'*curFt;
      
      u(i,j)=U(1);
      v(i,j)=U(2);
      
      cert(i,j) = rcond(A'*A);
      end
      
   end
end
 
u = u+uIn;
v = v+vIn;
end
