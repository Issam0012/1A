function s = calcul_structure_2(u_barre,b,Dx,Dy,lambda,epsilon)
    [n,m] = size(u_barre);
    N = m*n;
    u_barre_vect = u_barre(:);
    dux = Dx*u_barre_vect;
    duy = Dy*u_barre_vect;
    a = 1./sqrt(dux.^2+duy.^2+epsilon);
    W_k = spdiags(a,0,N,N);
    A = speye(N) - lambda*(-Dx'*W_k*Dx-Dy'*W_k*Dy);
    s = reshape(A\b,n,m);
end