function u = collage(r,s,interieur)

    r = double(r);
    s = double(s);

    [nb_lignes,nb_colonnes, nb_canaux] = size(r);
    nb_pixels = nb_lignes * nb_colonnes;
    e = ones(nb_pixels,1);
    Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
    Dx(end-nb_lignes+1:end,:) = 0;
    Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
    Dy(nb_lignes:nb_lignes:end,:) = 0;
    A = (-Dx'*Dx-Dy'*Dy);

    bord_r = ones(nb_lignes,nb_colonnes);
    bord_r(2:end-1,2:end-1) = 0;
    indices_bord_r = find(bord_r==1);

    n_bord_r = length(indices_bord_r);
    A(indices_bord_r,:) = sparse(1:n_bord_r,indices_bord_r,ones(n_bord_r,1),n_bord_r,nb_pixels);
    
    u = zeros(size(r));
    for k = 1:nb_canaux
        r_k = r(:,:,k);
        s_k = s(:,:,k);

        r_k = r_k(:);
        s_k = s_k(:);

        cible_x = Dx*r_k;
        cible_y = Dy*r_k;

        ds_x = Dx*s_k;
        ds_y = Dy*s_k;

        cible_x(interieur) = ds_x(interieur);
        cible_y(interieur) = ds_y(interieur);

        b_k = -Dx'*cible_x-Dy'*cible_y;
        b_k(indices_bord_r)=r_k(indices_bord_r);
        
        u_k=A\b_k;
        u(:,:,k) = reshape(u_k,nb_lignes,nb_colonnes);

    end
end