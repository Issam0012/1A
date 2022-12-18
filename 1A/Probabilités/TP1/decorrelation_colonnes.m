function [I_decorrelee,I_min] = decorrelation_colonnes(I,I_max)
I_decorrelee=I;
I_min = -I_max;
I_decorrelee(:,2:end)=I_decorrelee(:,2:end)-I_decorrelee(:,1:end-1);
end

