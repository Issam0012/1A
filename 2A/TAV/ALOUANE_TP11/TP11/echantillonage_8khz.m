% Spécifiez le chemin du répertoire contenant les fichiers MP3
chemin_entree = "C:\Users\Acer Nitro 5\Desktop\TAV\ALOUANE_TP11\TP11\arabic\";
% Spécifiez le chemin du répertoire de sortie pour les fichiers WAV
chemin_sortie = "C:\Users\Acer Nitro 5\Desktop\TAV\ALOUANE_TP11\TP11\arabic_8khz\";

% Obtenez la liste des fichiers MP3 dans le répertoire d'entrée
fichiers_mp3 = dir(fullfile(chemin_entree, '*.mp3'));

% Parcourez chaque fichier MP3
for i = 1:length(fichiers_mp3)
    nom_fichier = fichiers_mp3(i).name;
    
    % Lisez le fichier MP3
    [y, Fs] = audioread(fullfile(chemin_entree, nom_fichier));
    
    % Rééchantillonnez le signal audio à 8 kHz
    Fs_nouveau = 8000;
    y_resample = resample(y, Fs_nouveau, Fs);
    
    % Générez le nom de fichier de sortie avec l'extension WAV
    nom_fichier_sortie = strrep(nom_fichier, '.mp3', '.wav');
    
    % Enregistrez le signal audio rééchantillonné au format WAV dans le répertoire de sortie
    chemin_fichier_sortie = fullfile(chemin_sortie, nom_fichier_sortie);
    audiowrite(chemin_fichier_sortie, y_resample, Fs_nouveau);
    
end

disp('Conversion terminée.');
