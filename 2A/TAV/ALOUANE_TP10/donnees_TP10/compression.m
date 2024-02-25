function Y_modifie = compression(Y, m)
    [~,I] = maxk(Y,m,1,'ComparisonMethod','abs');
    Y_copie = Y;
    Y_modifie = Y;
    for i = 1:size(Y,2)
        Y_copie(I(:,i),i) = 0;
        Y_modifie(:,i) = Y_modifie(:,i) - Y_copie(:,i);
    end
end