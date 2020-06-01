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

%% Treino e Teste Kmeans
K = 3; 
Max_Its = 10;

for n = 1:Max_Its
    
    distM = squareform(pdist(data));
    [U, Z, Err] = kmeans(data,K);
    s = silhouette(data,U);
    disp(sprintf('Dunns index for kmeans %d', dunns(3,distM,U)));
    %% Acuracia
    acc(n) = acuracia(U, data(:,end));
    
end

[accMedia, desvioPadrao] = plotAccuracy( Max_Its, acc );

%% Region Decision
% [XY] = deciosionregion(data, K);