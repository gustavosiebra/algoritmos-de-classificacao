function [dataRandomized] = randomizeData(dataset)
    %% Parametros:
    % Entrada:
    %   dataset             - Base de dados a ser randomizada.
    %
    % Saida:
    %   datasetRandomized   - Base de dados randomizada.

    %% Define a quantidade de instancias.
    numofobs = length(dataset);

    %% Randomiza a base de dados.
    rearrangement = randperm(numofobs);
    dataRandomized = dataset(rearrangement,:);

end