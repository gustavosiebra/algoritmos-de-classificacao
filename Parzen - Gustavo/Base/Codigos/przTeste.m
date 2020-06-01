function [id, F] = przTeste(h,xTe, ndTr, prior, result)
    %% Parametros:
    % Entrada:  
    %   xTe     - Atributos de teste.
    %   ndTr    - Quantidade de classes
    %   prior   - Probabilidade da classe
    %   result  - base de dados dividido por classe

    % Saida:
    %   id   - labels

    %% Tamanho da base de teste
    [numLinhas, ~] = size(xTe);
    nC = length(ndTr); % number of classes
    %ns = length(dTe); % test set
    
    %% calculando a Janela de Parzen
    for i = 1:nC
        fu = parzenWindow(xTe,result{i}(:,1:end-1),h);
        F(i,:) = prior(:,i) .* fu;
    end

    %% Get predicted output for test set
    [pv0,id] = max(F);
    for i=1:length(numLinhas)
        pv(i,1) = ndTr(id(i));
    end

end