function u_kp1 = debruitage(b,u_k,lambda,Dx,Dy,epsilon)
    du_kx = Dx*u_k;
    du_ky = Dy*u_k;
    norm_duk = du_kx.^2+du_ky.^2;
    nb_pixel = length(u_k);
    W_k = spdiags(1./sqrt(norm_duk+epsilon),0,nb_pixel,nb_pixel);
    A_k = speye(length(b)) - lambda * (-Dx'*W_k*Dx-Dy'*W_k*Dy);
    u_kp1 = A_k\b;
end