function tmp = plotLabels(dataset)
    %% Parametros:
    % Entrada:  
    %   dataset - Base de dados.

    % Saída:
    %   tmp   - variavel aleatoria

   %% Classes
    setosa = dataset((dataset(:,5)==1),:);        % data for setosa
    versicolor = dataset((dataset(:,5)==2),:);    % data for versicolor
    virginica = dataset((dataset(:,5)==3),:);     % data for virginica
    
    %% plot caracteristicas
    Characteristics = {'sepal length','sepal width',...
        'petal length','petal width'};
    pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
    h = figure;
    for j = 1:6,
        x = pairs(j, 1);
        y = pairs(j, 2);
        subplot(2,3,j);
        plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
             [setosa(:,y) versicolor(:,y) virginica(:,y)], '.');
        xlabel(Characteristics{x},'FontSize',10);
        ylabel(Characteristics{y},'FontSize',10);
    end  
    
    tmp = 1;
end