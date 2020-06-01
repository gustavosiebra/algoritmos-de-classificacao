function[dataTr,dataTe,xTr,dTr,xTe,dTe,att] = separateData(data)
    %% Parametros:
    % Entrada:
    %   data     - Base de dados a ser randomizada.
    %
    % Saída:
    %   dataTr   - Base de Treinamento.
    %   dataTe   - Base de Teste.
    %   xTr      - Atributos de treinamento.
    %   dTr      - Classe de treinamento.
    %   xTe      - Atributos de teste.
    %   dTe      - Classe de teste.
    %   nTr      - Quantidade de padroes de treinamento.
    %   nTe      - Quantidade de padroes de teste.
    %   att      - Quantidade de atributos.

    %% Coeficiente de separacao treinamento/testes.
    coef = 0.8;

    %% Definição do número de atributos.
    [inst, att] = size(data);
    att = att-1;

    %% Quantidade de dados para treinamento/testes.
    nTr = round(coef * size(data,1));
    nTe = size(data,1) - nTr;

    %% Execução do hold-out.
    [dataTr, dataTe] = runHoldOut(data, coef);

    %% Definição das entradas dos padrões de treinamento.
    xTr = dataTr(:, 1:att);

    %% Definição da saída desejada dos padrões de treinamento.
    dTr = dataTr(:, end);

    %% Definição das entradas dos padrões de teste.
    xTe = dataTe(:, 1:att);

    %% Definição da saída desejada dos padrões de teste.
    dTe = dataTe(:, end);

end