function g = make2Dgaussian(N, sigma)
ind = -floor(N/2):floor(N/2);
x = ((N - 1)/2) + 1;
y = ((N - 1)/2) + 1;
[x,y] = meshgrid(ind, ind);
g = exp(-(x.^2 + y.^2) / (2*sigma*sigma));
g = g / sum(g(:));

% [x,y]=meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
% g=exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
% g=g./sum(g(:));
end