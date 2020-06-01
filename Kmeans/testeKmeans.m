function [id, M, dTr] = testeKmeans(data, K)
    %% Parametros:
    % Entrada:  
    %   data        - base de dados
    %   Max_Its     - numero de iteracoes.
    %   K           - quantidade de K.
    % Saida:
    %   id      - classes classficadas
    %   M       - media para novo centroide
    %   dTe     - classes de testes
    
    %% Normalizacao dos dados.
    dataset = normalizeData(data);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    xTr = dataset(:,end-1);
    dTr = dataset(:,end);
    [N,~] = size(dataset);

    %% Bayes Treino
    [ndTr, M, media, sigma] = bayesTraining(xTr, dTr);
    M = M';
    
    for r = 1 : N
        
        for k = 1:K
            Dist(:,k) = sum((xTr - repmat(M(k,:),N,1)).^2,2);
        end

        [C,id] = min(Dist,[],2);

        for k = 1:K
            if size(find(id == k)) > 0
                M(k,:) = mean(xTr(find(id == k),:));
            end
        end

        ndTr = dTr(id);

        %Calculo da Moda
        nC(r) = mode(ndTr(1:K,:));    
    end
end

