function [m,v] = estimation(echantillons)
    m = sum(echantillons)/length(echantillons);
    v = sum((echantillons-m).^2)/length(echantillons);
end