
% TP1 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : ALOUANE
% Prénom : Issam
% Groupe : 1SN-H

function varargout = fonctions_TP1_proba(varargin)

    switch varargin{1}     
        case 'ecriture_RVB'
            varargout{1} = feval(varargin{1},varargin{2:end});
        case {'vectorisation_par_colonne','decorrelation_colonnes'}
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
        case 'calcul_parametres_correlation'
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end}); 
    end

end

% Fonction ecriture_RVB (exercice_0.m) ------------------------------------
% (Copiez le corps de la fonction ecriture_RVB du fichier du meme nom)
function image_RVB = ecriture_RVB(image_originale)
nb_lignes=size(image_originale,1)/2;
nb_colonnes=size(image_originale,2)/2;
image_RVB=zeros(nb_lignes,nb_colonnes,3);
image_RVB(:,:,1)=image_originale(1:2:end,2:2:end);
image_RVB(:,:,3)=image_originale(2:2:end,1:2:end);
image_RVB(:,:,2)=(image_originale(1:2:end,1:2:end)+image_originale(2:2:end,2:2:end))/2;
end

% Fonction vectorisation_par_colonne (exercice_1.m) -----------------------
function [Vd,Vg] = vectorisation_par_colonne(I)
Vg=I(:,1:end-1);
Vd=I(:,2:end);
Vd=Vd(:);
Vg=Vg(:);
end

% Fonction calcul_parametres_correlation (exercice_1.m) -------------------
function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
ecart_type_d=sqrt( 1/length(Vd)*sum(Vd.^2) - mean(Vd)^2);
ecart_type_g=sqrt( 1/length(Vg)*sum(Vg.^2) - mean(Vg)^2);
covariance=1/length(Vg)*sum(Vd.*Vg)-mean(Vg)*mean(Vd);
r = covariance / (ecart_type_d * ecart_type_g);
a = covariance / (ecart_type_d^2);
b = mean(Vg)-a*mean(Vd);
end

% Fonction decorrelation_colonnes (exercice_2.m) --------------------------
function [I_decorrelee,I_min] = decorrelation_colonnes(I,I_max)
I_decorrelee=I;
I_min = -I_max;
I_decorrelee(:,2:end)=I_decorrelee(:,2:end)-I_decorrelee(:,1:end-1);
end



