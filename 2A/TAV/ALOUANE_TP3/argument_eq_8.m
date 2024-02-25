function [poids,argument] = argument_eq_8(mu_test,sigma_test,liste_nvg,F)
    expo = exp(-(liste_nvg'-mu_test).^2./(2*sigma_test.^2));
    A = expo./(sigma_test*sqrt(2*pi));
    poids = A\F';
    argument = sum((F'-A*poids).^2);
end