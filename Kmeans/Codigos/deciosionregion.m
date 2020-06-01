function [XY, id, M] = deciosionregion(data, K)
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
        
        temp = (randperm(length(nxTr)))'; % randomize rows
        M(:,:,j) = nxTr(temp(1:K,1),:); % select first K rows as initial centroids

        for k = 1:K
            Dist(:,k) = sum((repmat(M(k,:,j),N,1) - XY).^2,2);
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
        
    end 
end