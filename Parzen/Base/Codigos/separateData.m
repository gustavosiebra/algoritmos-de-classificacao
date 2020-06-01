function[dataTr,dataTe,xTr,dTr,xTe,dTe,att] = separateData(data)
    %% Parametros:
    % Entrada:
    %   data     - Base de dados a ser randomizada.
    %
    % Sa�da:
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

    %% Defini��o do n�mero de atributos.
    [inst, att] = size(data);
    att = att-1;

    %% Quantidade de dados para treinamento/testes.
    nTr = round(coef * size(data,1));
    nTe = size(data,1) - nTr;

    %% Execu��o do hold-out.
    [dataTr, dataTe] = runHoldOut(data, coef);

    %% Defini��o das entradas dos padr�es de treinamento.
    xTr = dataTr(:, 1:att);

    %% Defini��o da sa�da desejada dos padr�es de treinamento.
    dTr = dataTr(:, end);

    %% Defini��o das entradas dos padr�es de teste.
    xTe = dataTe(:, 1:att);

    %% Defini��o da sa�da desejada dos padr�es de teste.
    dTe = dataTe(:, end);

end