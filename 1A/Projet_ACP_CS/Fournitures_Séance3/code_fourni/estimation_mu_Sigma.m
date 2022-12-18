
function [mu, sigma] = estimation_mu_Sigma(X)

mu = X'*ones(length(X),1)/length(X);

Xc = X - mu;

sigma = Xc'*Xc/length(Xc);

end