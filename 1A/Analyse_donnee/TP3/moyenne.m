
% La fonction moyenne

function M = moyenne(X)

R = X(:,:,1);
V = X(:,:,2);
B = X(:,:,3);

R = R(:);
V = V(:);
B = B(:);

A = R+V+B;

R = R./max(1, A);
V = V./max(1, A);

M = [mean(R) mean(V)];

end