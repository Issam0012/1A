function AD = attache_donnees(I,moyennes,variances)
    n = length(moyennes);
    AD = zeros(size(I,1),size(I,2),n);
    for i=1:n
        AD(:,:,i) = (log(variances(i)) + ((I-moyennes(i)).^2)/(variances(i)))/2;
    end
end