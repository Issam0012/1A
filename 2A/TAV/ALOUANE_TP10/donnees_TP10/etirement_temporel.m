function y_modifie = etirement_temporel(y, f_ech, pourcentage)
    Y = TFCT(y, f_ech, 2048, 512, 'hann');
    C = 1:pourcentage:size(Y,2);
    phi = angle(Y(:,1));
    Y_modifie = zeros(size(Y,1),length(C));
    for i=1:length(C)
        c = floor(C(i));
        alpha = C(i) - c;
        rho = (1-alpha)*abs(Y(:,c)) + alpha*abs(Y(:,c+1));
        Y_modifie(:,i) = rho .* exp(1j*phi);
        dphi = angle(Y(:,c+1)) - angle(Y(:,c));
        phi = phi + dphi;
    end
    [y_modifie,~] = ITFCT(Y_modifie, f_ech, 512, 'hann');
end