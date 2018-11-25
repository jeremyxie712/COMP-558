function  [P, K, R, C] =  calibrate(XYZ, xy)

%  Create the data matrix to be used for the least squares.
%  and perform SVD to find matrix P.

%  BEGIN CODE STUB (REPLACE WITH YOUR OWN CODE)
[size_r2,size_c2] = size(xy);
[size_r3,size_c3] = size(XYZ);
x = XYZ(:,1);
y = XYZ(:,2);
z = XYZ(:,3);
u = xy(:,1);
v = xy(:,2);
A = zeros(2 * size_r2, 11);
B = zeros(2 * size_r2, 1);

for i = 1 : size_r2
    A(2 * i - 1,:)= [x(i), y(i), z(i), 1, 0, 0, 0, 0, -u(i)*x(i), -u(i)*y(i), -u(i)*z(i)];
    A(2 * i,:) =    [0, 0, 0, 0, x(i), y(i), z(i), 1, -v(i)*x(i), -v(i)*y(i), -v(i)*z(i)];
    B(2 * i - 1,1)= u(i);
    B(2 * i,1) =    v(i);
end

P=A\B;
 
 
P= [ P(1) P(2) P(3) P(4);
     P(5) P(6) P(7) P(8);
     P(9) P(10) P(11) 1];
[K,R,C] = decomposeProjectionMatrix(P);



  
  

%  END CODE STUB 

P = K * R * [eye(3), -C];
[K, R, C] = decomposeProjectionMatrix(P);
