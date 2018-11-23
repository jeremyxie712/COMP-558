function [kp] = sift(level1,level2,level3,sigma)
level1 = imresize(level1,2);
level3 = imresize(level3,0.5);
[m,n] = size(level2);
kp={};
index = 1;
thre=0.018;
for i = 2:n-1
    for j = 2:m-1
        if level2(i,j)<level2(i-1,j) && level2(i,j)<level2(i,j-1) && level2(i,j)<level2(i+1,j) && level2(i,j)<level2(i,j+1) && level2(i,j)<level2(i-1,j-1) && level2(i,j)<level2(i+1,j+1) && level2(i,j)<level2(i-1,j+1) && level2(i,j)<level2(i+1,j-1)
            if level2(i,j)<level1(i-1,j) && level2(i,j)<level1(i,j-1) && level2(i,j)<level1(i+1,j) && level2(i,j)<level1(i,j+1) && level2(i,j)<level1(i-1,j-1) && level2(i,j)<level1(i+1,j+1) && level2(i,j)<level1(i-1,j+1) && level2(i,j)<level1(i+1,j-1) && level2(i,j)<level1(i,j)
                if level2(i,j)<level3(i-1,j) && level2(i,j)<level3(i,j-1) && level2(i,j)<level3(i+1,j) && level2(i,j)<level3(i,j+1) && level2(i,j)<level3(i-1,j-1) && level2(i,j)<level3(i+1,j+1) && level2(i,j)<level3(i-1,j+1) && level2(i,j)<level3(i+1,j-1)
                    if abs(level2(i,j)-level2(i-1,j))>thre && abs(level2(i,j)-level2(i+1,j))>thre && abs(level2(i,j)-level2(i,j+1))>thre && abs(level2(i,j)-level2(i,j-1))>thre
                        if abs(level2(i,j)-level2(i-1,j-1))>thre && abs(level2(i,j)-level2(i+1,j-1))>thre && abs(level2(i,j)-level2(i-1,j+1))>thre && abs(level2(i,j)-level2(i+1,j+1))>thre
                        extrema = level2(i,j);
                        kp{index}{1,1,1}={j,i,sigma};
                        index = index+1;
                        end
                    end
                end
            end
        end
        if level2(i,j)>level2(i-1,j) && level2(i,j)>level2(i,j-1) && level2(i,j)>level2(i+1,j) && level2(i,j)>level2(i,j+1) && level2(i,j)>level2(i-1,j-1) && level2(i,j)>level2(i+1,j+1) && level2(i,j)>level2(i-1,j+1) && level2(i,j)>level2(i+1,j-1)
            if level2(i,j)>level1(i-1,j) && level2(i,j)>level1(i,j-1) && level2(i,j)>level1(i+1,j) && level2(i,j)>level1(i,j+1) && level2(i,j)>level1(i-1,j-1) && level2(i,j)>level1(i+1,j+1) && level2(i,j)>level1(i-1,j+1) && level2(i,j)>level1(i+1,j-1)
                if level2(i,j)>level3(i-1,j) && level2(i,j)>level3(i,j-1) && level2(i,j)>level3(i+1,j) && level2(i,j)>level3(i,j+1) && level2(i,j)>level3(i-1,j-1) && level2(i,j)>level3(i+1,j+1) && level2(i,j)>level3(i-1,j+1) && level2(i,j)>level3(i+1,j-1)
                    if abs(level2(i,j)-level2(i-1,j))>thre && abs(level2(i,j)-level2(i+1,j))>thre && abs(level2(i,j)-level2(i,j+1))>thre && abs(level2(i,j)-level2(i,j-1))>thre
                        if abs(level2(i,j)-level2(i-1,j-1))>thre && abs(level2(i,j)-level2(i+1,j-1))>thre && abs(level2(i,j)-level2(i-1,j+1))>thre && abs(level2(i,j)-level2(i+1,j+1))>thre
                        extrema = level2(i,j);
                        kp{index}{1,1,1}={j,i,sigma};
                        index = index+1;
                        end
                    end
                end
            end
        end
        
    end
end

end