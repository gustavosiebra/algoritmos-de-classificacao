function [ndTr, prior, result] = przTreino(dataTr, dTr)
    %% Parametros:
    % Entrada:
    %   dataTr  - Base de Treino.
    %   dTr     - Classes.
    %
    % Saida:
    %   prior       - Probabilidade da classe
    %   ndTr        - Quantidade de classes
    %   result      - base de dados dividido por classe
    
   %% Computar a probabilidade da classe
    ndTr = unique(dTr);
    nC = length(ndTr);

    for i=1:nC
        prior(i) = sum(double(dTr == ndTr(i)))/length(dTr);
    end
    
    %% Separando a base de cada por classe
    classe = []; result = cell(1,nC);

    for w = 1 : nC
        for j = 1:size(dataTr,1) %%loop da matriz de treino
            p = dataTr(j, :); %%padrao do momento
            if dataTr(j, end) == w 
                classe = [classe;p];
                result{w} = classe;
            end
        end
        classe = [];
    end
    
end
