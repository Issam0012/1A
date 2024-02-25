function [Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre)

    y_buffered = buffer(y,n_fenetre,n_fenetre - n_decalage,'nodelay');

    if (fenetre=='hann')
        w = hann(n_fenetre);
    else
        w = ones(n_fenetre,1);
    end
    
    w = repmat(w,1,size(y_buffered,2));
    y_filtered = y_buffered .* w;

    Y = fft(y_filtered);
    Y = Y(1:(n_fenetre/2+1),:);

    k = 0:1:(n_fenetre/2);
    m = 0:1:(size(Y,2)-1);

    valeurs_t = (m*n_decalage)/f_ech;
    valeurs_f = (k*f_ech)/n_fenetre;

end