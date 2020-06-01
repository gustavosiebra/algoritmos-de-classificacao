function [dataTr, dataTe] = runHoldOut(data, coef)
    %% Parametros:
    % Entrada:
    %   data   - Base de dados a ser dividida.
    %   coef   - Coeficiente de proporcionalidade.
    %
    % Saída:
    %   dataTr  - Base de dados para treinamento.
    %   dataTe  - Base de dados para teste.

    %% Obter quantitativo de treinamento.
    sizeDataset = size(data, 1);
    n = round(coef * sizeDataset);

    %% Obter conjunto de treinamento.
    dataTr = data(1:n,:);

    %% Obter conjunto de testes.
    dataTe = data(n+1:end,:);
end