function [pics_t, pics_f] = pics_spectraux(S, eta_t, eta_f, epsilon)

    voisinage = true(eta_f, eta_t);
    max_locaux = imdilate(S,voisinage);

    [pics_f, pics_t] = find(S >= max(max_locaux,epsilon));
end