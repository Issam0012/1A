
% La fonction MCI
function Beta_chapeau = MCI(x, y)
A = [-x(:) ones(length(x(:)),1)];
B = log(y(:));
Beta_chapeau = pinv(A) * B;
end