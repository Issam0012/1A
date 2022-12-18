
% La fonction MCO
function Beta_chapeau = MCO(x, y)
A = [x.^2 x.*y y.^2 x y ones(length(x),1); 1 0 1 0 0 0];
B = [zeros(length(x), 1); 1];
Beta_chapeau = pinv(A) * B;
end
