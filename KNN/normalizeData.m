function [dataNormalized] = normalizeData(dataset)
    %% Parametros:
    % Entrada:
    %   dataset             - Base de dados a ser normalizada.
    %
    % Saida:
    %   datasetNormalized   - Base de dados normalizada.

    %% Verifica a quantidade de instancias/atributos.
    [inst, att] = size(dataset);
    maxvalue = max(dataset);
    minvalue = min(dataset);

    %% Aloca a matriz para os dados normalizados.
    dataNormalized = zeros(inst, att-1);
    for i=1:inst
        for j=1:att-1
            dataNormalized(i,j)=(dataset(i,j)-minvalue(j))/...
            (maxvalue(j)-minvalue(j));
        end
    end

    %% Concatenar com as saídas
    dataNormalized = [dataNormalized, dataset(:,end)]; 
end