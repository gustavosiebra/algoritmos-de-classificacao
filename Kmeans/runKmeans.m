%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Le arquivo
data = load('iris2D.txt');

%% Treino e Teste Kmeans
K = 3; 
Max_Its = 10;
N = 50;

for n = 1:N
    [id, M, dTr] = testeKmeans(data, K);
    %% Acuracia
    acc(n) = acuracia(id,dTr);
end

%% Plot Acuracia
[accMedia, desvioPadrao] = plotAccuracy( N, acc );

%% Plot Region Decision
%[XY, id, M1] = deciosionregion(data, K);

%% Plot Region Decision
% [XY, id,  M1] = decisaoRegiao(data, K);