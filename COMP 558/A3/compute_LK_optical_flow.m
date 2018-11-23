function [Vx,Vy] = compute_LK_optical_flow(frame_1,frame_2,type_LK)

% You have to implement the Lucas Kanade algorithm to compute the
% frame to frame motion field estimates. 
% frame_1 and frame_2 are two gray frames where you are given as inputs to 
% this function and you are required to compute the motion field (Vx,Vy)
% based upon them.
% -----------------------------------------------------------------------%
% YOU MUST SUBMIT ORIGINAL WORK! Any suspected cases of plagiarism or 
% cheating will be reported to the office of the Dean.  
% You CAN NOT use packages that are publicly available on the WEB.
% -----------------------------------------------------------------------%

% There are three variations of LK that you have to implement,
% select the desired alogrithm by passing in the argument as follows:
% "LK_naive", "LK_iterative" or "LK_pyramid"

switch type_LK

    case "LK_naive"
        % YOUR IMPLEMENTATION GOES HERE
        frame_1 = im2double(rgb2gray(frame_1));
        frame_2 = im2double(rgb2gray(frame_2));
        windowSize = 41;
        
        h = fspecial('gaussian',[5 5],4);
        img_1 = imfilter(frame_1,h);
        img_2 = imfilter(frame_2,h);
        [Fx,Fy] = gradient(img_1);
        
        Vx = zeros(size(img_1));
        Vy = zeros(size(img_2));
        G = fspecial('gaussian',windowSize,floor(windowSize / 6));
        
        time_d  = img_2 - img_1;
        
        wIx2 = imfilter(Fx .^ 2,G);
        wIy2 = imfilter(Fy .^ 2,G);
        wIxy = imfilter(Fx .* Fy,G);
        wIxt = imfilter(Fx .* time_d,G);
        wIyt = imfilter(Fy .* time_d,G);
        
        for i = 1:size(img_1,1)
            for j = 1:size(img_1,2)
                A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
                B=[-wIxt(i,j); -wIyt(i,j)];  
                velocity= A\B;
                Vx(i,j)=velocity(1,1);
                Vy(i,j)=velocity(2,1);
            end
        end

    case "LK_iterative"
        % YOUR IMPLEMENTATION GOES HERE
        
        frame_1 = im2double(rgb2gray(frame_1)); %converting the image to grayscale
        frame_2 = im2double(rgb2gray(frame_2));
        windowSize = 41;
        iterations = 3;
        
        h = fspecial('gaussian',[5 5],4);
        img_1 = imfilter(frame_1,h);
        img_2 = imfilter(frame_2,h);            
        G = fspecial('gaussian',windowSize,floor(windowSize / 6));
        
        u = zeros(size(img_1));
        v = zeros(size(img_2));
        
        time_d  = img_2 - img_1;
        [Fx,Fy] = gradient(img_1);
        
        wIx2 = imfilter(Fx .^ 2,G);
        wIy2 = imfilter(Fy .^ 2,G);
        wIxy = imfilter(Fx .* Fy,G);
        wIxt = imfilter(Fx .* time_d,G);
        wIyt = imfilter(Fy .* time_d,G);
        
        for i = 1:size(img_1,1)
            for j = 1:size(img_1,2)
                A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
                B=[-wIxt(i,j); -wIyt(i,j)];  
                velocity= A\B;
                u(i,j)=velocity(1,1);
                v(i,j)=velocity(2,1);
            end
        end
        
        for i = 1:iterations
            [u,v] = LucasKanadeRefined(u,v,img_1,img_2,windowSize);
%             [u,v] = LucasKanadeRefined(u,v,img_1,img_2);
        end
        
        Vx = u; Vy = v;
        
        
        
        
        
        
        
        

    case "LK_pyramid"
        % YOUR IMPLEMENTATION GOES HERE
        frame_1 = im2double(rgb2gray(frame_1));
        frame_2 = im2double(rgb2gray(frame_2));
        numlevels = 3;
        windowSize = 9;
        window_h = floor(windowSize / 2);
        iterations = 3;
        
        img_1 = frame_1;
        img_2 = frame_2;
        
        h = fspecial('gaussian',[5 5],4);
        img_1 = imfilter(img_1,h);
        img_2 = imfilter(img_2,h);
        
        G = fspecial('gaussian',windowSize,floor(windowSize / 6));
%         G = fspecial('average',windowSize);

        
        %Creating gaussian pyramid%
        %The ides is to create my two base levels first for two images and
        %then go through the rest 2 levels for each image to do ietrations
        %over them. 
        pyramid1 = img_1;
        pyramid2 = img_2;
        
        for i = 2:numlevels
            img_1 = reduce(img_1,windowSize);
            img_2 = reduce(img_2,windowSize);
            pyramid1(1:size(img_1,1),1:size(img_1,2),i) = img_1;
            pyramid2(1:size(img_2,1),1:size(img_2,2),i) = img_2;
        end
        
        baseIm1 = pyramid1(1:(size(pyramid1,1)/(2^(numlevels-1))), 1:(size(pyramid1,2)/(2^(numlevels-1))), numlevels);
        baseIm2 = pyramid2(1:(size(pyramid2,1)/(2^(numlevels-1))), 1:(size(pyramid2,2)/(2^(numlevels-1))), numlevels);
        
        u = zeros(size(baseIm1));
        v = zeros(size(baseIm2));
        
        time_d  = baseIm2 - baseIm1;
        [Fx,Fy] = gradient(baseIm1);
        
        wIx2 = imfilter(Fx .^ 2,G);
        wIy2 = imfilter(Fy .^ 2,G);
        wIxy = imfilter(Fx .* Fy,G);
        wIxt = imfilter(Fx .* time_d,G);
        wIyt = imfilter(Fy .* time_d,G);
        
        for i = 1:size(baseIm1,1)
            for j = 1:size(baseIm1,2)
                A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
                B=[-wIxt(i,j); -wIyt(i,j)];  
                velocity= A\B;
                u(i,j)=velocity(1,1);
                v(i,j)=velocity(2,1);
            end
        end
        
        %Calculating iterations Lucas Kanade algorithm%
        for i = 1:iterations
            [u,v] = LucasKanadeRefined(u,v,baseIm1,baseIm2,windowSize);
%             [u,v] = LucasKanadeRefined(u,v,baseIm1,baseIm2);
        end
        
        for i = 2:numlevels
            uEx = 2 * imresize(u,size(u)*2,'bilinear');   
            vEx = 2 * imresize(v,size(v)*2,'bilinear');
            curIm1 = pyramid1(1:(size(pyramid1,1)/(2^(numlevels - i))), 1:(size(pyramid1,2)/(2^(numlevels - i))), (numlevels - i)+1);
            curIm2 = pyramid2(1:(size(pyramid2,1)/(2^(numlevels - i))), 1:(size(pyramid2,2)/(2^(numlevels - i))), (numlevels - i)+1);
            
            %Now we run the iterative method again for the two higher
            %levels%
            
            [u,v] = LucasKanadeRefined(uEx,vEx,curIm1,curIm2,windowSize);
%             [u,v] = LucasKanadeRefined(uEx,vEx,curIm1,curIm2);
            
            %Now we run iterative refinement on the next two levels by
            %calling the independent refinement function
            for j = 1:iterations
                [u,v] = LucasKanadeRefined(u,v,curIm1,curIm2,windowSize);
%                  [u,v] = LucasKanadeRefined(u,v,curIm1,curIm2);
            end
        end
        
        Vx = u; Vy = v;




    




end
