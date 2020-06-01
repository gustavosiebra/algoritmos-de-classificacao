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

    %temp = (randperm(length(xTr)))'; % randomize rows
    %M = xTr(temp(1:K,1),:); % select first K rows as initial centroids
    M = [0.0600; 0.5096; 0.8160]; %iris.txt 
    %M = [0.654171851761921;0.128553412309537;0.321211633150798]; %wine.txt
    
%     y = zeros(1, size(data,1));
% 
%     % enquanto não estabilizar
%     for epoca = 1 : Max_Its
% 
%         % Rotulando as amostras (Etapa E)
%         [~, clusters] = sort(pdist2(M, xTr));
%         yNew = clusters(1,:);
%         
%         [~,id] = min(clusters);
% 
%         if ( sum(y==yNew) == size(data,1) )
%             fprintf('K-Means estabilizou na época %d\n', epoca);
%             break
%         end    
%         y = yNew;
% 
% 
%         % Posicionado os prototipos (Etapa M)
%         for i=1: K
%             M(i, :) = mean(xTr(y==i, :));
%         end
% 
% 
%     end
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %         Z = zeros(N,K);
    %         for m = 1:N
    %             Z(m,id(m)) = 1;
    %         end
    %         
    %         e(n) = sum(sum(Z.*Dist)./N);
    %         fprintf('%d Error = %f\n', n, e(n));
    %         %Mo = M;
    
    end
end

