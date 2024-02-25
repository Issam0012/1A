function bornes_V = get_bornes_V(i, j, u_k, t)
    [H, W, ~] = size(u_k);
    i_min = max(1, i - t);
    i_max = min(H, i + t);
    j_min = max(1, j - t);
    j_max = min(W, j + t);
    [Y, X] = meshgrid(i_min:i_max, j_min:j_max);
    bornes_V = [Y(:), X(:)];
end