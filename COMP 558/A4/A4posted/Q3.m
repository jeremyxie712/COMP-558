function q3_output = Q3()
%  The scene object is a unit cube.

XYZ = [0 0 0; ...
    0 0 1;
    0 1 0;
    0 1 1;
    1 0 0;
    1 0 1;
    1 1 0;
    1 1 1];

%  Set up a projection matrix by choosing K, R, C.

%  For K, just go with coordinates on the projection plane, and put the projection plane at f = 10.
%  Set the principal point to be slightly different from (0,0),  namely (20, -30).  
%
%  Note that in examples with real images, we would expect the principal point to be roughly
%  at the center pixel (Nx/2, Ny/2),  since the (1,1) and (Nx,Ny) would be at opposite corners of the sensor.
%  We would also expect the K11 and K22 coefficients to include a change in
%  units from mm to top pixels.   We have not done this here.   Essentially
%  we are treating 1 mm = 1 pixel.

K = [300 0 20; 0 300 -30; 0 0 1];

%  Set camera axes to be near parallel to the object (world) axes. 
%  Only have a small rotation about y axis.

num_degrees = 15;
theta_y = num_degrees *pi/180;
R_y = [cos(theta_y) 0 sin(theta_y);  0 1 0;  -sin(theta_y) 0  cos(theta_y)];

%  When theta_y = 0,  the camera coordinate axes are same as object axes.
%  We put the camera at a negative z value.  It is looking in the positive z
%  direction.   Note the XY of camera corresponds to the center XY of the
%  cube.

C = [0.5 0.5 -2]';

P = K * R_y * [ eye(3), -C];

%  now plot the projection of the cube corners for this chosen projection matrix

close all
figure; hold on;

numPositions = size(XYZ,1);

%  Draw in black square the projected point positions according to the true model.

xy = zeros(numPositions, 2);
for j = 1:numPositions
    p = P*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    
    xy(j,1) = x;
    xy(j,2) = y;
    plot(x, y,'sk');
end


%Image shift%
%-------------------------------------------------------------------------%
% matrix_K = eye(3);
% matrix_K(1,3) = 10;
% K2 = matrix_K * K;
% P2 = K2 * R_y * [ eye(3), -C];
% for j = 1:numPositions
%     p = P2*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);
%     
%     xy(j,1) = x;
%     xy(j,2) = y;
%     plot(x, y,'r*');
% end



% num_degrees_2 = 0.5;
% theta_y_2 = num_degrees_2 *pi/180;
% R_2 = [cos(theta_y_2) 0 sin(theta_y_2);  0 1 0;  -sin(theta_y_2) 0  cos(theta_y_2)];
% R_2 = R_2 * R_y;
% P3 = K2 * R_2 * [ eye(3), -C];
% for j = 1:numPositions
%     p = P3*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);
%     
%     xy(j,1) = x;
%     xy(j,2) = y;
%     plot(x, y,'g*');
% end


% matrix_C = eye(3);
% matrix_C(1,3) = -0.01;
% matrix_C(1,2) = 0.015;
% C2 = matrix_C * C;
% disp(C2);
% P4 = K2 * R_y * [ eye(3), -C2];
% for j = 1:numPositions
%     p = P4*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
%     x = p(1)/p(3);
%     y = p(2)/p(3);
%     
%     xy(j,1) = x;
%     xy(j,2) = y;
%     plot(x, y,'b*');
% end

%-------------------------------------------------------------------------%


%Image scaling%
%-------------------------------------------------------------------------%
matrix_K_2 = eye(3);
matrix_K_2(1,1) = 0.5;
matrix_K_2(2,2) = 0.5;
K3 = matrix_K_2 * K;
P5 = K3 * R_y * [ eye(3), -C];
for j = 1:numPositions
    p = P5*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    
    xy(j,1) = x;
    xy(j,2) = y;
    plot(x, y,'ro');
end


matrix_C_2 = eye(3);
matrix_C_2(1,1) = 1.1;
matrix_C_2(2,2) = 1.1;
matrix_C_2(3,3) = 1.1;
C3 = matrix_C_2 * C;
disp(C3);
P6 = K3 * R_y * [ eye(3), -C3];
for j = 1:numPositions
    p = P6*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    
    xy(j,1) = x;
    xy(j,2) = y;
    plot(x, y,'bo');
end
end