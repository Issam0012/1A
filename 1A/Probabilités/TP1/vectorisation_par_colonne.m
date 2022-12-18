function [Vd,Vg] = vectorisation_par_colonne(I)
Vg=I(:,1:end-1);
Vd=I(:,2:end);
Vd=Vd(:);
Vg=Vg(:);
end

