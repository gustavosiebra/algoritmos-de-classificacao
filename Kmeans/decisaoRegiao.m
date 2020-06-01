function [XY, id, M] = decisaoRegiao(data, K)
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
    
    %% Normalizacao dos dados.
    data = normalizeData(data);

    %% Embaralhar base de dados.
    data = randomizeData(data);

    %% Separacao dos dados.
    %[~,dataTe,xTr,~,xTe,dTe, ~] = separateData(data);
    
    %% Tamanho da base de teste    
    minx = min(data(:, 1));
    maxx = max(data(:, 1));
    miny = min(data(:, 2));
    maxy = max(data(:, 2));
    
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

    %% Separacao dos dados.
    p = combnk(1:size(data(:,1:end-1),2),2);
    p = sortrows(p);

    for j = 1:size(p,1)

        nxTr = data(:,p(j,:));

        [N,D] = size(XY);
        dTr = data(:,end);
        
        %temp = (randperm(length(nxTr)))'; % randomize rows
        %M = nxTr(temp(1:K,1),:); % select first K rows as initial centroids
        
        switch j
            case 1, M = [0.1976,0.5801; 0.4553,0.3021; 0.7320,0.4816]; % 78%Combinacao 1
            case 2, M = [0.1961,0.0786; 0.3423,0.5018; 0.6238,0.7243]; %84%Combinacao 2
            case 3, M = [0.2169,0.1349; 0.5752,0.5610; 0.5882,0.8080]; %82%Combinacao 3
            case 4, M = [0.5908,0.0786; 0.3231,0.5876; 0.4530,0.8278]; %87%Combinacao 4
            case 5, M = [0.5908,0.0600; 0.2972,0.5417; 0.4625,0.8292]; %89%Combinacao 5
            case 6, M = [0.0786,0.0600; 0.5687,0.5302; 0.7910,0.8313]; %98%Combinacao 6
        end

        for k = 1:K
            Dist(:,k) = sum((repmat(M(k,:),N,1) - XY).^2,2);
        end

        [C,id] = min(Dist,[],2);

        for k = 1:K
            if size(find(id == k)) > 0
                M(k,:,j) = mean(XY(find(id == k),:));
            end
        end
        
        %% Plot
        h = figure;
        scatter(XY(:,1), XY(:,2), 40, cmap1(id,:), 'filled');
        hold on;
        scatter(nxTr(:,1), nxTr(:,2), 80, cmap2(dTr',:), 'filled');
        
        switch j
            case 1
                print(h, '-depsc', 'decisionboundary_12.eps');
            case 2
                print(h, '-depsc', 'decisionboundary_13.eps');
            case 3
                print(h, '-depsc', 'decisionboundary_14.eps');
            case 4
                print(h, '-depsc', 'decisionboundary_23.eps');
            case 5
                print(h, '-depsc', 'decisionboundary_24.eps');
            case 6
                print(h, '-depsc', 'decisionboundary_34.eps');
            otherwise 
                ...
        end
        
    end 
end

