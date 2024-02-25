function [U,k] = recuit(U,k,AD,T,beta)
    [~,~,N] = size(AD);
    [nb_lignes, nb_colonnes] = size(k);
    for i = 1:nb_lignes
		for j = 1:nb_colonnes
            ks = k(i,j);
			ks_new = randi(N);
            while ks_new==ks
                ks_new = randi(N);
            end
            Us = U(i,j);
            k_voisins = k(max(i-1,1):min(i+1,nb_lignes),max(j-1,1):min(j+1,nb_colonnes));
            Us_new = AD(i,j,ks_new) + beta*regularisation(k_voisins,ks_new,ks_new);
            if (Us_new<Us)
                k(i,j) = ks_new;
            else
                if rand() < exp(-(Us_new-Us)/T)
                    k(i,j) = ks_new;
                end
            end
		end
	end
end