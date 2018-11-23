function im_ran = question3(T,threshold,orientThre)
[im_out,grad_orient] = edgeDetection('james.jpg');
[x,y] = find(im_out == 1);
[rowX,colX] = size(x);
[rowY,colY] = size(y);

% T = 20;
% threshold = 2;
% orientThre = 1;


max_vote = 0;
in_pts = {};
out_pts = {};

for i = 1:T
    vote = 0;
    index = randi(rowX);
    randX = x(index); 
    randY = y(index);
    x_temp = [1:512];
    y_temp = [];
    y_temp = tan(grad_orient(randX,randY)) .* (x_temp - randX) + randY;
    point_in = {};
    point_out = {};
    in_index = 1;
    out_index = 1;

    for j = 1:rowX
        candi_X = x(j);
        candi_Y = y(j);

        euc_dis = sqrt((candi_X - x_temp) .* (candi_X - x_temp) + (candi_Y - y_temp) .* (candi_Y - y_temp));
        
        %polar way calculating distance%
        %r = abs(candi_X .* cos(grad_orient(candi_X,candi_Y)) + candi_Y .* sin(grad_orient(candi_X,candi_Y)));
        %euc_dis = abs(candi_X .* cos(grad_orient(candi_X,candi_Y)) + candi_Y .* sin(grad_orient(candi_X,candi_Y)) - r); 
        
        
        if min(euc_dis) < threshold & abs(grad_orient(candi_X,candi_Y) - grad_orient(randX,randY)) < orientThre
            point_in{in_index}{1,1} = {candi_Y,candi_X};
            in_index = in_index+1;
            %disp('here');
            vote = vote+1;
        else
            point_out{out_index}{1,1} = {candi_Y,candi_X};
            out_index = out_index+1;

        end
    end
    
    if vote >= max_vote
        max_vote = vote;
        in_pts = point_in';
        out_pts = point_out';      
    end
    
end
hold on;
in_pts_x = [];
in_pts_y = [];
for i = 1:length(in_pts)
    in_pts_x(i) = in_pts{i}{1}{1};
    in_pts_y(i) = in_pts{i}{1}{2};
end
plot(in_pts_x(:),in_pts_y(:),'r.');

out_pts_x = [];
out_pts_y = [];
for i = 1:length(out_pts)
    out_pts_x(i) = out_pts{i}{1}{1};
    out_pts_y(i) = out_pts{i}{1}{2};
end
plot(out_pts_x(:),out_pts_y(:),'k.');



end