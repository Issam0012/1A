function paires = appariement(pics_t, pics_f, n_v, delta_t, delta_f)
    paires = [];
    for i=1:length(pics_t)
        m = pics_t(i);
        k = pics_f(i);
        indices = find((pics_t-m)>0 & delta_t>=(pics_t-m) & delta_f>=abs(k-pics_f),n_v);
        for j=1:length(indices)
            indice = indices(j);
            paires = [paires; [k,pics_f(indice),m,pics_t(indice)]];
        end
    end
end