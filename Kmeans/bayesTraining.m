function [ndTr, prior, media, sigma] = bayesTraining(xTr, dTr)
    %% Parametros:
    % Entrada:
    %   xTr      - Atributos dos padroes de treinamento.
    %   dTr      - Classes de treinamento.
    %   dTe      - Classes de teste.
    %
    % Saída:
    %   ndTr    - Quantidade de classes
    %   prior   - Probabilidade da classe
    %   media   - Media das classes
    %   sigma   - Matriz de covariancia

    %% Quantidade de classes
    ndTr = unique(dTr);
    nC = length(ndTr);

    %% Computar a probabilidade da classe
    for i=1:nC
        prior(i) = sum(double(dTr == ndTr(i)))/length(dTr);
    end

    %% Calculo da Media e Desvio Padrao
    % parameters from training set
    for i=1:nC
        xi = xTr((dTr == ndTr(i)),:);
        media(i,:) = mean(xi,1);
        sigma(:,:,i) = cov(xi,1);
    end

end