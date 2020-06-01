function [XY] = deciosionregion(dataset, opc)
    %% Parametros:
    % Entrada:  
    %   dataset - Base de dados.

    % Saida:
    %   XY   - background do plot

    %% Cores
    
    cmap2 = jet(3);
    cmap2 = cmap2*0.8;
    cmap1 = (cmap2 + 0.6) * 1.2;
    cmap1(cmap1 > 1) = 1;
    
    %% Tamanho da base de teste    
    minx = min(dataset(:, 1));
    maxx = max(dataset(:, 1));
    miny = min(dataset(:, 2));
    maxy = max(dataset(:, 2));
    
    %% Passo
    stepx = (maxx - minx) *.01;
    stepy = (maxy - miny) *.01;
    %inc = 0.005;
    
    x1 = minx:stepx:maxx;
    x2 = miny:stepy:maxy;
    
    [X, Y] = meshgrid(x1, x2);
    
    %% Concatencao
    XY = [X(:), Y(:)];
    att = size(XY, 2);

    %% Normalizacao dos dados.
    dataset = normalizeData(dataset);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    [~,~,xTr,dTr,~,~] = separateData(dataset);

    p = combnk(1:size(xTr,2),2);
    p = sortrows(p);

    for k = 1:size(p,1)

        nxTr = xTr(:,p(k,:));

        %% Bayes Treino
        [ndTr, prior, media, sigma] = bayesTraining(nxTr, dTr);

        %% Bayes Teste
        %[id] = bayesTest(xTe, dTe, ndTr, prior, media, sigma);

        %% Probability for test set
        nC = length(ndTr); % number of classes

        %% calculando funções de verossimilhança ...
            % e probabilidades a posteriori
        switch opc
            % caso geral, matriz de covariância ...
                    % diferentes e prioris diferentes
            case 1 
                for i = 1:nC
                    fu = mvnpdf(XY,media(i,:),sigma(:,:,i));
                    F(i,:) = prior(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e prioris diferentes
            case 2 
                for i = 1:nC
                    fu = mvnpdf(XY,media(i,:),...
                         diag(diag(ones(att))).*.5);
                    F(i,:) = prior(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e equiprovável
            case 3 
                prior = ones(1, nC)./nC;
                for i = 1:nC
                    fu = mvnpdf(XY,media(i,:),...
                         diag(diag(ones(att))).*.5);
                    F(i,:) = prior(:,i) .* fu;
                end
            case 4 % equiprovável e matriz de covariância diferentes
                prior = ones(1, nC)./nC;
                for i = 1:nC
                    fu = mvnpdf(XY,media(i,:),sigma(:,:,i));
                    F(i,:) = prior(:,i) .* fu;
                end
            otherwise 
                ...
        end

        %% Get predicted output for test set
        [~,id] = max(F);
        
        %%  Plot Superficie de Decisao
%         figure;
%         for i = 1:nC
%     
%             plot(XY(id == i, 1), XY(id == i, 2), colors(i, :));
%             hold on;
%             classeI = dataset(dataset(:, end) == i, :);
%             plot(classeI(:, 1), classeI(:, 2),  colors2(i, :),...
%             'MarkerFaceColor', colors(i, 2));
%         end
        
        h = figure;
        scatter(XY(:,1), XY(:,2), 40, cmap1(id,:), 'filled');
        hold on;
        scatter(nxTr(:,1), nxTr(:,2), 80, cmap2(dTr',:), 'filled');
        
%         switch k
%             case 1
%                 print(h, '-depsc', 'decisionboundary_type4_12.eps');
%             case 2
%                 print(h, '-depsc', 'decisionboundary_type4_13.eps');
%             case 3
%                 print(h, '-depsc', 'decisionboundary_type4_14.eps');
%             case 4
%                 print(h, '-depsc', 'decisionboundary_type4_23.eps');
%             case 5
%                 print(h, '-depsc', 'decisionboundary_type4_24.eps');
%             case 6
%                 print(h, '-depsc', 'decisionboundary_type4_34.eps');
%             otherwise 
%                 ...
%         end
    end 
end