
function [mu, sigma] = estimation_mu_Sigma(X)

mu = X'*ones(length(X),1)/length(X);

mu1 = mu(1);
mu2 = mu(2);

Xc1 = X(:,1) - mu1;
Xc2 = X(:,2) - mu2;

Xc = [Xc1, Xc2];

sigma = Xc'*Xc/length(Xc);

end