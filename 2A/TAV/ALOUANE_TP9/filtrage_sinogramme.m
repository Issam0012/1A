function s = filtrage_sinogramme(sinogramme)

    [nb_rayons,nb_theta] = size(sinogramme);
    f=abs(linspace(-1,1,nb_rayons)');
    filtre=repmat(f,[1 nb_theta]);
    
    sino_trans=fftshift(fft(sinogramme));
    sino_filtre=ifftshift(sino_trans.*filtre);
    s=real(ifft(sino_filtre));

end