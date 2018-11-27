function [para_out] = Q2()
im1 = imread('c1.JPG');
readPositions 

[P,K,R,C] = calibrate(XYZ,xy1);
numPositions = size(XYZ,1);

% %All these codes are imported from Q1.m that plots the original started
% %code 
% for camera = 1:2
%     switch camera
%         case 1
%             Iname = 'c1.jpg';
%             xy = xy1;
%         case 2
%             Iname = 'c2.jpg';
%             xy = xy2;
%     end
%     
%     %  Display image with keypoints
%     
%     if (1) % (trial == 1)   % only do it first time through
%         I = imread(Iname);
%         NX = size(I,2);
%         NY = size(I,1);
%         imageInfo = imfinfo(Iname);
%         figure;
%         imshow(I);
%         title(Iname);
%         hold on
%         
%         %  Draw in green the keypoints locations that were hand selected.
%         
%         for j = 1:numPositions
%             plot(xy(j,1),xy(j,2),'g*');
%         end
%         
%         [P, K, R, C] = calibrate(XYZ, xy);
%         
%         %Now we change the K matrix 
% %         twoTrans = K;  %2d translation matrix
% % %         twoTrans(1,1) = K(1,1);
% % %         twoTrans(2,2) = K(2,2);
% % %         twoTrans(3,3) = K(3,3);
% % %         twoTrans(1,2) = K(1,2);
% %         twoTrans(1,3) = K(1,3) * 10.3;
% %         twoTrans(2,3) = K(2,3) * 10.3;
% %         K = twoTrans;
% %         
% %         P = K * R * [eye(3) -C];
% 
%         
%         %  Normalize the K so that the coefficients are more meaningful.
%         K = K/K(3,3);
%                 
%         for j = 1:numPositions
%             p = P*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%             x = p(1)/p(3);
%             y = p(2)/p(3);
%             
%             %  Draw in white square the projected point positions according to the fit model.
%             
%             plot(ceil(x),ceil(y),'ws');
%         end
%         
%         switch camera
%             case 1
%                 K1 = K;  R1 = R;  C1 = C;
%             case 2
%                 K2 = K;  R2 = R;  C2 = C;
%         end
%         
%     end
% end

twoTrans = K;  %2d translation matrix
%         twoTrans(1,1) = K(1,1);
%         twoTrans(2,2) = K(2,2);
%         twoTrans(3,3) = K(3,3);
%         twoTrans(1,2) = K(1,2);
% twoTrans(1,3) = K(1,3) + 10.3;
% twoTrans(2,3) = K(2,3) + 10.3;
%  K = K + 3;
K(1,3) = K(1,3) + 5;
K(2,3) = K(2,3) + 5;
        
P = K * R * [eye(3) -C];
disp(P);
xy = zeros(numPositions, 2);
for j = 1:numPositions
    p = P*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    
    xy(j,1) = x;
    xy(j,2) = y;
    plot(x, y,'sk');
end


xyR = zeros(numPositions,2);
for j = 1:numPositions
    p = P*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    
    xyR(j,1) = x;
    xyR(j,2) = y;
    plot(x, y,'sk');
end




end