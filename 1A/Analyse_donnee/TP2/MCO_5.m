
%La fonction MCO en considérant cinq paramètres
function Beta_chapeau = MCO_5(x, y)
A = [x.^2-y.^2 x.*y x y ones(length(x),1)];
B = -y.^2;
Beta_chapeau = pinv(A) * B;
Beta_chapeau  = [Beta_chapeau(1); Beta_chapeau(2); 1-Beta_chapeau(1); Beta_chapeau(3); Beta_chapeau(4); Beta_chapeau(5)];
end