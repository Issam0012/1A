function s = calcul_structure_3(u_barre,u,Dx,Dy,Phi,epsilon,mu_prime,gamma)
    u_barre = u_barre(:);
    ux = Dx*u_barre;
    uy = Dy*u_barre;
    uxx = -Dx'*Dx*u_barre;
    uxy = -Dx'*Dy*u_barre;
    uyy = -Dy'*Dy*u_barre;

    b = (uxx.*(uy.^2+epsilon)+uyy.*(ux.^2+epsilon)-2*ux.*uy.*uxy)./((ux.^2+uy.^2+epsilon).^(3/2));
    
    Phi = Phi(:);
    u_vect = u(:);
    s = u_barre - gamma*(real(ifft2(Phi.*(fft2(u_barre)-fft2(u_vect))))-mu_prime*b);

    s = reshape(s, size(u));
end