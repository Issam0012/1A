function A = matrice_A(N,alpha,beta,gamma)
    e = ones(N,1);
    D = spdiags([e -2*e e],[-1 0 1],N,N);
    D(N,1) = 1;
    D(1,N) = 1;
    A = speye(N) + gamma*(alpha*D - beta*(D'*D));
end