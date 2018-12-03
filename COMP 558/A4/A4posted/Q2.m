function [para_out] = Q2()
im1 = imread('c1.JPG');
readPositions 
xy = xy1;
[P,K,R,C] = calibrate(XYZ,xy);
numPositions = size(XYZ,1);
aspRat = K(2,2) / K(1,1);


%Image shift part%
%---------------------------%

% Iname = 'first image for shifting';
% newMatrix = eye(3);
% newMatrix(1,3) = 75;
% K1 = newMatrix * K;
% figure;
% imshow(im1);
% title(Iname);
% hold on      
% %  Draw in green the keypoints locations that were hand selected.       
% for j = 1:numPositions
%     plot(xy(j,1),xy(j,2),'g*');
% end
% P1 = K1 * R * [eye(3), -C];      
% %  Normalize the K so that the coefficients are more meaningful.
% K1 = K1/K1(3,3);               
% for j = 1:numPositions
%     p = P1*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);         
%     %  Draw in white square the projected point positions according to the fit model.        
%     plot(ceil(x),ceil(y),'ws');
% end





% rotMatrix = eye(3);
% % rotMatrix(1,3) = 0.0127;
% rotMatrix(1,3) = 1/75;
% R2 = rotMatrix * R;
% %  Draw in green the keypoints locations that were hand selected.       
% for j = 1:numPositions
%     plot(xy(j,1),xy(j,2),'g*');
% end
% P2 = K * R2 * [eye(3), -C];      
% %  Normalize the K so that the coefficients are more meaningful.
% K = K/K(3,3);               
% for j = 1:numPositions
%     p = P2*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);         
%     %  Draw in white square the projected point positions according to the fit model.        
%     plot(ceil(x),ceil(y),'rs');
% end
% hold off;




% tranMatrix = eye(3);
% tranMatrix(1,3) = -0.044;
% tranMatrix(2,3) = -0.0137;
% C1 = tranMatrix * C;
% for j = 1:numPositions
%     plot(xy(j,1),xy(j,2),'g*');
% end
% P3 = K * R * [eye(3), -C1];      
% K = K/K(3,3);               
% for j = 1:numPositions
%     p = P3*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);            
%     plot(ceil(x),ceil(y),'bs');
% end





%Image expansion part%
%----------------------------------%


%Changing K for expansion 

Iname4 = 'first image for scaling';
scaMatrix = eye(3);
K2 = K;
scaMatrix(1,1) = 1/2;
scaMatrix(2,2) = 1/2;
K2 = scaMatrix * K2;
figure;
imshow(im1);
title(Iname4);
hold on             
for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end
P4 = K2 * R * [eye(3), -C];      
K = K/K(3,3);               
for j = 1:numPositions
    p = P4*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);         
    plot(ceil(x),ceil(y),'ws');
end





%Changing C for expansion%

% Iname5 = 'first image changing C for scaling';
% figure;
% imshow(im1);
% title(Iname5);
% hold on 

scaTrans = eye(3);
scaTrans(1,1) = 2;
scaTrans(2,2) = 2;
scaTrans(3,3) = 2;
C2 = scaTrans * C;
for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end
P5 = K * R * [eye(3), -C2];      
K = K/K(3,3);               
for j = 1:numPositions
    p = P5*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);            
    plot(ceil(x),ceil(y),'rs');
end
hold off;

end