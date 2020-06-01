%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Carregando arquivo
data = load('iris.txt');
%data = load('wine.txt');
%k = input('Enter the number of nearest neighbors:  ');

%% definindo variaveis
R = 30; % numero de realizacoes
k = 25; %Enter the number of nearest neighbors
confMatrix = zeros(0,R);

setosa = data((data(:,5)==1),:);        % data for setosa
versicolor = data((data(:,5)==2),:);    % data for versicolor
virginica = data((data(:,5)==3),:);     % data for virginica

for r = 1:R    
    %% Normalizacao dos dados.
    dataset = normalizeData(data);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    [dataTr,dataTe,xTr,dTr,xTe,dTe, att] = separateData(dataset);

    %% Calculo do Knn.
    [ndTr,nC,acc] = KNN(dTr,xTr,dTe,xTe,size(xTe,1),size(xTr,1),k);
    
    %% Acuracia
    accuracy(r) = acuracia(nC, dTe);

end

%% plot caracteristicas somente para Iris
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

%% Plot da Acuracia
[accMedia, desvioPadrao] = plotAccuracy(r, accuracy);
disp(['media acuracia = ',num2str(accMedia*100),'%']) 

