function [beta, norm_grad_f_beta, f_beta, norm_delta, nb_it, exitflag] ...
          = Algo_Newton(Hess_f_C14, beta0, option)
%************************************************************
% Fichier  ~gergaud/ENS/Optim1a/TP-optim-20-21/Newton_ref.m *
% Novembre 2020                                             *
% Université de Toulouse, INP-ENSEEIHT                      *
%************************************************************
%
% Newton r�sout par l'algorithme de Newton les problemes aux moindres carres
% Min 0.5||r(beta)||^2
% beta \in R^p
%
% Parametres en entrees
% --------------------
% Hess_f_C14 : fonction qui code la hessiennne de f
%              Hess_f_C14 : R^p --> matrice (p,p)
%              (la fonction retourne aussi le residu et la jacobienne)
% beta0  : point de départ
%          real(p)
% option(1) : Tol_abs, tolérance absolue
%             real
% option(2) : Tol_rel, tolérance relative
%             real
% option(3) : nitimax, nombre d'itérations maximum
%             integer
%
% Parametres en sortie
% --------------------
% beta      : beta
%             real(p)
% norm_gradf_beta : ||gradient f(beta)||
%                   real
% f_beta    : f(beta)
%             real
% res       : r(beta)
%             real(n)
% norm_delta : ||delta||
%              real
% nbit       : nombre d'itérations
%              integer
% exitflag   : indicateur de sortie
%              integer entre 1 et 4
% exitflag = 1 : ||gradient f(beta)|| < max(Tol_rel||gradient f(beta0)||,Tol_abs)
% exitflag = 2 : |f(beta^{k+1})-f(beta^k)| < max(Tol_rel|f(beta^k)|,Tol_abs)
% exitflag = 3 : ||delta)|| < max(Tol_rel delta^k),Tol_abs)
% exitflag = 4 : nombre maximum d'itérations atteint
%      
% ---------------------------------------------------------------------------------

% TO DO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exitflag=4;
nb_it = 0;
beta=beta0;
Tol_abs=option(1);
Tol_rel=option(2);
n_itmax=option(3);
[H_f, res0, J_res0]= Hess_f_C14(beta);
A=H_f;
B=J_res0'*res0;
delta= A\B;
norm_delta=norm(delta);
norm_grad_f_beta=norm(J_res0'*res0);
f_beta=(norm(res0)^2)*0.5;
while nb_it<n_itmax
    norm_delta=norm(delta);
    f_beta_anc=f_beta;
    beta=beta-delta;
    [H_f, res, J_res]= Hess_f_C14(beta);
    A=H_f;
    B=J_res'*res;
    delta=A\B;
    norm_grad_f_beta=norm(J_res'*res);
    f_beta=(norm(res)^2)*0.5;
    nb_it=nb_it+1;
    if norm_grad_f_beta < max(Tol_rel*norm((J_res0.'*res0)),Tol_abs)
        exitflag = 1;
        break
    elseif abs(f_beta-f_beta_anc) < max(Tol_rel*abs(f_beta_anc),Tol_abs)
        exitflag = 2;
        break
    elseif norm(delta) < max(Tol_rel*norm(f_beta),Tol_abs)
        exitflag = 3;
        break
    end
end
end
