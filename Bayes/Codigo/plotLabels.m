function tmp = plotLabels(dataset)
    %% Parametros:
    % Entrada:  
    %   dataset - Base de dados.

    % Saída:
    %   tmp   - variavel aleatoria

   %% Classes
    setosa = dataset((dataset(:,end)==1),:);        % data for setosa
    versicolor = dataset((dataset(:,end)==2),:);    % data for versicolor
    virginica = dataset((dataset(:,end)==3),:);     % data for virginica
    
    %% plot caracteristicas
    Characteristics = {'sepal length','sepal width',...
        'petal length','petal width'};
%     pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
    
    %% Separacao dos dados de treino.

    xTr = dataset(:, 1: end-1);

    p = combnk(1:size(xTr,2),2);
    p = sortrows(p);
    
    col = round(size(p,1)/2);
    
    lin = round((col)/2);
    
    h = figure;
    
    for k = 1:size(p,1)      
%         for j = 1:size(p,1),
            x = p(k,1);
            y = p(k,2);
            subplot(lin,col,k);
            plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
                 [setosa(:,y) versicolor(:,y) virginica(:,y)], '.');
            xlabel(Characteristics{x},'FontSize',10);
            ylabel(Characteristics{y},'FontSize',10);
%         end     
    end
    
%     print (h, '-depsc', 'myfig.eps');

    tmp = 1;
       
end