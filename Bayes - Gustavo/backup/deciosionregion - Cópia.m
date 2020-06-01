function [X, Y, XY, P] = deciosionregion(dataset)
    %% Parametros:
    % Entrada:  
    %   dataset - Base de dados.

    % Saída:
    %   XY   - background do plot

    %% Cores
    
    cmap2 = jet(3);
    cmap2 = cmap2*0.8;
    cmap1 = (cmap2 + 0.6) * 1.2;
    cmap1(cmap1 > 1) = 1;
    
    %colors = ['.r'; '.g'; '.b'];
    %colors2 = ['oc'; 'oy'; 'ok'];
    
    %% Tamanho da base de teste    
    minx = min(dataset(:, 1));
    maxx = max(dataset(:, 1));
    miny = min(dataset(:, 2));
    maxy = max(dataset(:, 2));
    
    %% Passo
    stepx = (maxx -minx) *.01;
    stepy = (maxy -miny) *.01;
    %inc = 0.005;
    
    [X, Y] = meshgrid(minx:stepx:maxx, miny:stepy:maxy);
    
    %% Concatencao
    XY = [X(:), Y(:)];
    numLinhas = size(XY, 1);
    
    %% Separacao dos dados de treino.

    xTr = dataset(:, 1: 2);
    dTr = dataset(:, end);

%     p = combnk(1:size(xTr,2),2);
% 
%     for k = 1:size(p,1)
% 
%         nxTr = xTr(:,p(k,:));

        %% Bayes Treino
        [ndTr, prior, media, sigma] = bayesTraining(xTr, dTr);

        %% Bayes Teste
        %[id] = bayesTest(xTe, dTe, ndTr, prior, media, sigma);

        %% Probability for test set
        nC = length(ndTr); % number of classes

        for j = 1:numLinhas
            for i = 1:nC
                fu = mvnpdf(ones(nC,1)*XY(j,:),media,sigma(:,:,i));
                P(j,:) = prior(i).*prod(fu,2)';
            end
        end

        %% Get predicted output for test set
        [~,id] = max(P,[],2);
        
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
        
        figure;
        scatter(XY(:,1), XY(:,2), 40, cmap1(id',:), 'filled');
        hold on;
        scatter(xTr(:,1), xTr(:,2), 80, cmap2(dTr',:), 'filled');

%     end 
end