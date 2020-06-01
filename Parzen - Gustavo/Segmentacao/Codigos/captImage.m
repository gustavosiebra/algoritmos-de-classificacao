function [imgSelec] = captImage(nC, img_orig)
    %% Parametros:
    % Entrada:
    %   nC       - Numero de Classes.
    %   img_orig - Imagem Original.
    %
    % Saida:
    %   imgSelec  - Base de treino.
    
    %% Seleciona o conjunto de Treinamento
    % Use o mouse 
    
    figure, imshow(img_orig);
    
    for i = 1: nC
        rect = getrect;
        rect = int64(rect);
        imgSelec{i} = img_orig(rect(2):rect(2)+ rect(4), rect(1): ...
            rect(1) + rect(3), :);
    end

    %% Figuras
    %figure, subplot(1,2,1), imshow(imgSelec{1});
    %figure, subplot(1,2,1), imshow(imgSelec{2});

    
end


