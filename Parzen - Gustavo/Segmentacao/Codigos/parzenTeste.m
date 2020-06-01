function [id, F] = parzenTeste(h, xTe, prior, result)
    %% Parametros:
    % Entrada:  
    %   xTe     - Atributos de teste.
    %   ndTr    - Quantidade de classes
    %   prior   - Probabilidade da classe
    %   result  - base de dados dividido por classe

    % Saida:
    %   id   - labels

	F = [];
    %% Tamanho da base de teste
    [numLinhas, ~] = size(xTe.x);
    
    %% calculando a Janela de Parzen
    for i = 1:length(prior)
        fu = parzenWindow(xTe.x,result{i},h);
        F(i,:) = prior(:,i) .* fu;
    end

    %% Get predicted output for test set
    [pv0,id] = max(F);

end