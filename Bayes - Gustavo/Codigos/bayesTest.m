function [id, F] = bayesTest(xTe, dTe, ndTr, prior, media,sigma, opc)
    %% Parametros:
    % Entrada:  
    %   xTe     - Atributos de teste.
    %   dTe     - Classes de teste.
    %   ndTr    - Quantidade de classes
    %   prior   - Probabilidade da classe
    %   media   - Media das classes
    %   sigma   - Matriz de covariancia

    % Saida:
    %   id   - labels

    %% Tamanho da base de teste
    [numLinhas, numAttr] = size(xTe);
    nC = length(ndTr); % number of classes
    %ns = length(dTe); % test set
    
    %% calculando funções de verossimilhança e probabilidades a posteriori
    switch opc
        % caso geral, matriz de covariância ...
            %diferentes e prioris diferentes
        case 1          
            for i = 1:nC
                if (rcond(sigma(:,:,i)) < 1e-12)
                    sigma(:,:,i) = sigma(:,:,i) + (0.01 * eye(numAttr));
                end
                fu = mvnpdf(xTe,media(i,:),sigma(:,:,i));
                F(i,:) = prior(:,i) .* fu;
            end
        % matriz de covariância diagonal com ...
            %mesma variância e prioris diferentes
        case 2 
            for i = 1:nC
                fu = mvnpdf(xTe,media(i,:),...
                     diag(diag(ones(numAttr))).*.5);
                F(i,:) = prior(:,i) .* fu;
            end
        % matriz de covariância diagonal com mesma variância e equiprovável
        case 3 
            prior = ones(1, nC)./nC;
            for i = 1:nC
                fu = mvnpdf(xTe,media(i,:),...
                     diag(diag(ones(numAttr))).*.5);
                F(i,:) = prior(:,i) .* fu;
            end
        case 4 % equiprovável e matriz de covariância diferentes
            prior = ones(1, nC)./nC;
            for i = 1:nC
                if (rcond(sigma(:,:,i)) < 1e-12)
                    sigma(:,:,i) = sigma(:,:,i) + (0.01 * eye(numAttr));
                end
                fu = mvnpdf(xTe,media(i,:),sigma(:,:,i));
                F(i,:) = prior(:,i) .* fu;
            end
        % caso geral, matriz de covariância diferentes e prioris diferentes
        otherwise 
            ...
    end

    %% Get predicted output for test set
    [pv0,id] = max(F);
    for i=1:length(numLinhas)
        pv(i,1) = ndTr(id(i));
    end

end