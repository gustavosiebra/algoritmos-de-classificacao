function [XY] = deciosionregion(dataset,h)
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

    %% Normalizacao dos dados.
    dataset = normalizeData(dataset);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);
    
    %% Combinacao
    p = combnk(1:size(dataset(:,1:end-1),2),2);
    p = sortrows(p);
    
    %% Treino e Teste
    for k = 1:size(p,1)

        dataTr = [dataset(:,p(k,:)) dataset(:,end)];
        dTr = dataset(:,end);

        %% Parzen Treino
        [ndTr, prior, result] = przTreino(dataTr, dTr);

        %% Parzen Teste
        [id, F] = przTeste(h, XY, ndTr, prior, result);
        
        %% Plot
        h = figure;
        scatter(XY(:,1), XY(:,2), 40, cmap1(id,:), 'filled');
        hold on;
        scatter(dataTr(:,1), dataTr(:,2), 80, cmap2(dTr',:), 'filled');
        
%         switch k
%             case 1
%                 print(h, '-depsc', 'decisionboundary_12.eps');
%             case 2
%                 print(h, '-depsc', 'decisionboundary_13.eps');
%             case 3
%                 print(h, '-depsc', 'decisionboundary_14.eps');
%             case 4
%                 print(h, '-depsc', 'decisionboundary_23.eps');
%             case 5
%                 print(h, '-depsc', 'decisionboundary_24.eps');
%             case 6
%                 print(h, '-depsc', 'decisionboundary_34.eps');
%             otherwise 
%                 ...
%         end
    end 
end