function [prior, result] = parzenTreino(dataTr)
    %% Parametros:
    % Entrada:
    %   dataTr  - Base de Treino.
    %   dTr     - Classes.
    %
    % Saida:
    %   prior       - Probabilidade da classe
    %   result      - base de dados dividido por classe
    
   %% Computar a probabilidade da classe
    ndTr = unique(dataTr.y);
    nC = length(ndTr);

    for i=1:nC
        prior(i) = sum(double(dataTr.y == ndTr(i)))/length(dataTr.y);
    end
    
    %% Separando a base de cada por classe
    classe = []; result = cell(1,nC);

    for w = 1 : nC
        for j = 1:size(dataTr.x,1) %%loop da matriz de treino
            p = dataTr.x(j, :); %%padrao do momento
            if dataTr.y(j,:) == w 
                classe = [classe;p];
                result{w} = classe;
            end
        end
        classe = [];
    end
    
end
