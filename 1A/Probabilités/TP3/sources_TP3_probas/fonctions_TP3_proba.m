
% TP3 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : ALOUANE
% Prénom : Issam
% Groupe : 1SN-H

function varargout = fonctions_TP3_proba(varargin)

    switch varargin{1}
        
        case 'matrice_inertie'
            
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
            
        case {'ensemble_E_recursif','calcul_proba'}
            
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});
    
    end
end

% Fonction ensemble_E_recursif (exercie_1.m) ------------------------------
function [E,contour,G_somme] = ...
    ensemble_E_recursif(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)
    
    contour(i,j) = 0;

    if size(E,1)<card_max
        for a=1:8
            z = [i j] + voisins(a,:);
            x=z(1);
            y=z(2);
            Gxy=[G_x(x, y) G_y(x, y)];
            if sum(G_somme.*Gxy)/(norm(G_somme)*norm(Gxy))>cos_alpha && contour(x,y)==1
                E=[E;x y];
                [E, contour, G_somme]=ensemble_E_recursif(E,contour,G_somme,x,y,voisins,G_x,G_y,card_max,cos_alpha);

            end
        end
    end
end

% Fonction matrice_inertie (exercice_2.m) ---------------------------------
function [M_inertie,C] = matrice_inertie(E,G_norme_E)
    pi=sum(G_norme_E);
    x=sum(G_norme_E.*E(:,1))/pi;
    y=sum(G_norme_E.*E(:,2))/pi;
    m11=sum((G_norme_E.*(E(:,1)-x).^2))/pi;
    m22=sum((G_norme_E.*(E(:,2)-y).^2))/pi;
    m12=sum((G_norme_E.*(E(:,2)-y).*(E(:,1)-x)))/pi;
    M_inertie=zeros(2,2);
    M_inertie(1,1)=m22;
    M_inertie(2,2)=m11;
    M_inertie(2,1)=m12;
    M_inertie(1,2)=M_inertie(2,1);
    C=zeros(1,2);
    C(2)=x;
    C(1)=y;

end

% Fonction calcul_proba (exercice_2.m) ------------------------------------
function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)

    x_min = min(E_nouveau_repere(:,1));
    y_min = min(E_nouveau_repere(:,2));
    x_max = max(E_nouveau_repere(:,1));
    y_max = max(E_nouveau_repere(:,2));
    largeur = x_max-x_min;
    longeur = y_max-y_min;
    N = largeur*longeur;
    probabilite = 1-binocdf(length(E_nouveau_repere),floor(N),p);

    
end
