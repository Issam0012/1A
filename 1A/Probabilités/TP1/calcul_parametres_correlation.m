function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
ecart_type_d=sqrt( 1/length(Vd)*sum(Vd.^2) - mean(Vd)^2);
ecart_type_g=sqrt( 1/length(Vg)*sum(Vg.^2) - mean(Vg)^2);
covariance=1/length(Vg)*sum(Vd.*Vg)-mean(Vg)*mean(Vd);
r = covariance / (ecart_type_d * ecart_type_g);
a = covariance / (ecart_type_d^2);
b = mean(Vg)-a*mean(Vd);
end

