%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Le arquivo
data = load('iris.txt');

%%tempo
t = cputime;

%% Declare and Initialize Variabels
fprintf('Initializing variables');
K = 3; % number of clusters
iterCentroids = 100; % number of times K means runs to find the best centroid
iterKMeans = 5; % number of times K means runs with different initial centroids
fprintf('...done\n\n');

%% Run K Means
for i=1:iterKMeans
    
    fprintf(' ********* Running K means iteration %d ***********\n\n',i);
    [centroids cost idx] = runKMeans(data, K, iterCentroids);
    fprintf('Cost after %d iteration : %f\n\n',i,cost);
    
    if i==1
        bestCentroids = centroids;
        bestCost = cost;
        bestidx = idx;
    elseif (i>1 && cost<bestCost) % stores the best clustering
        bestCentroids = centroids;
        bestCost = cost;
        bestidx = idx;   
    end
    fprintf('Best cost : %f\n\n',bestCost);  

    XCompressed = centroids(idx,:);
    
    acc(i) = acuracia(bestidx,data(:,end));

end

[accMedia, desvioPadrao] = plotAccuracy( iterKMeans, acc );

%% Display original and best compressed image
XCompressed = bestCentroids(bestidx,:);

fprintf('Program executed in %f seconds or %f minutes\n\n', cputime-t, (cputime-t)/60);
