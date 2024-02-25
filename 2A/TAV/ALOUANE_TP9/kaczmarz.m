function f = kaczmarz(p,W,n_boucles)

    n_mesures = size(W,1);
    k_max = n_boucles;
    T_W = W';
    norm_W = sum(W.^2,2);
    n_pixel = size(W,2);
    f = zeros(n_pixel,1);

    for k=1:k_max
        for i=1:n_mesures
            norm_wi = norm_W(i);
            wi = T_W(:,i);
            if norm_wi ~= 0
                f = f + ((p(i)-wi'*f)*wi)/norm_wi;
            end
        end
    end

end