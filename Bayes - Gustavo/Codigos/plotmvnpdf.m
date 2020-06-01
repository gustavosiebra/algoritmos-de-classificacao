function [XY] = plotmvnpdf(dataset,opc)
    %% Parametros:
    % Entrada:  
    %   dataset - Base de dados.
    %   opc:
    %       1 - caso geral, matriz de covariância diferentes e prioris diferentes
    %       2 - matriz de covariância diagonal com mesma variância e prioris diferentes
    %       3 - matriz de covariância diagonal com mesma variância e equiprovável
    %       4 - equiprovável e matriz de covariância diferentes

    % Saida:
    %   XY   - background do plot
    
    cores = jet(3);
    cor = jet(10);
    
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
    
    %% Separacao dos dados de treino.

%     xTr = dataset(:, 1: 2);
%     dTr = dataset(:, end);

%     xTr = dataset(:, 1: end-1);
%     dTr = dataset(:, end);

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

        [v id] = max(F);
        
        RD = reshape(id,[length(X) length(X)]);
%         figure;
%         surf(RD);
        h = figure;
        surf(x1,x2,reshape(v,[length(X) length(X)]), reshape(cores(id,:),[length(X) length(X) 3]))
%         figure;
%         % base das gaussianas
%         contour(x1,x2,reshape(v,[length(X) length(X)]), reshape(cor(id,:),[length(X) length(X) 3]));

%         switch k
%             case 1
%                 print(h, '-depsc', 'plotGauss_type4_12.eps');
%             case 2
%                 print(h, '-depsc', 'plotGauss_type4_13.eps');
%             case 3
%                 print(h, '-depsc', 'plotGauss_type4_14.eps');
%             case 4
%                 print(h, '-depsc', 'plotGauss_type4_23.eps');
%             case 5
%                 print(h, '-depsc', 'plotGauss_type4_24.eps');
%             case 6
%                 print(h, '-depsc', 'plotGauss_type4_34.eps');
%             otherwise 
%                 ...
%         end
       
    end      
end