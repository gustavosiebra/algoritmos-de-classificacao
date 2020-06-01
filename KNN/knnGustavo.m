%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%%
clc;
clear all;
close all;

% Step 1
irisdata = load ('iris.txt');
k = input('Enter the number of nearest neighbors:  ');

setosa = irisdata((irisdata(:,5)==1),:);        % data for setosa
versicolor = irisdata((irisdata(:,5)==2),:);    % data for versicolor
virginica = irisdata((irisdata(:,5)==3),:);     % data for virginica

kMax = 120;

%for k=1:kMax
    
    % Definicao do numero de realizacoes.
    R = 10;
    confMatrix = zeros(3,3);

    for r = 1:R

        %Step 2: Randomizing and dividing data into 1:1 ratio for training and
        %testing

        split = 0;
        count = 0;

        while(count~=1)
            numofobs = length(irisdata);
            rearrangement = randperm(numofobs);
            newirisdata = irisdata(rearrangement,:);
            split = ceil(numofobs/5);
            count = count + 1;
        end

        % Separate data
        dataTe = newirisdata(1:split,:);
        dataTr = newirisdata(split+1:end,:);

        % Separate and normalize Training of Test
        xTe = dataTe(:,1:end-1);
        xTe = normalize(xTe);
        dTe = dataTe(:,end);

        xTr = dataTr(:,1:end-1);
        xTr = normalize(xTr);
        dTr = dataTr(:,end);

        numoftestdata = size(xTe,1);
        numoftrainingdata = size(xTr,1);
        
        % Calculo do Knn.
        [ndTr,nC,acuracia] = KNN(dTr,xTr,dTe,xTe,numoftestdata,numoftrainingdata,k);

        aC(r) = acuracia/numoftestdata * 100;

        % Calculo da matriz de confusao por realizacao.
        %confMatrix(r,:,:) = confusionmat(nC, dTe);

        [C,order] = confusionmat(nC, dTe);
        confMatrix = C + confMatrix;

    end
    
    acuraciaMedia(k) = mean(aC);
    desvioPadrao(k) = std(aC);

%end 

% figure, gscatter(irisdata(:,1),irisdata(:,2),irisdata(:,end));
% figure, gscatter(irisdata(:,1),irisdata(:,3),irisdata(:,end));
% figure, gscatter(irisdata(:,1),irisdata(:,4),irisdata(:,end));
% figure, gscatter(irisdata(:,2),irisdata(:,3),irisdata(:,end));
% figure, gscatter(irisdata(:,2),irisdata(:,4),irisdata(:,end));
% figure, gscatter(irisdata(:,3),irisdata(:,4),irisdata(:,end));

Characteristics = {'sepal length','sepal width','petal length','petal width'};
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

figure, plot(aC); ylabel('Acuracia','FontSize',10);
figure, plot(acuraciaMedia); 
xlabel('K','FontSize',10);
ylabel('Acuracia','FontSize',10);
figure, plot(desvioPadrao); 
xlabel('K','FontSize',10);
ylabel('Desvio Padrao','FontSize',10);

