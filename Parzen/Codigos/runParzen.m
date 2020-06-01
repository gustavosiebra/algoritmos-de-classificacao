%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Tamanho da Janela
h = 0.005;

%% Le arquivo
data = load('iris.txt');

%% Normalizacao dos dados.
dataset = normalizeData(data);

%% Quantidade de Realizacoes
for i = 1 : 30
    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    [dataTr,dataTe,xTr,dTr,xTe,dTe, att] = separateData(dataset);

    %% Parzen Treino
    [ndTr, prior, result] = przTreino(dataTr, dTr);

    %% Parzen Teste
    [id, F] = przTeste(h, xTe, ndTr, prior, result);

    %% Acuracia
    acc(i) = acuracia(id, dTe);
end

%% Plot Acuracia
% [accMedia, desvioPadrao] = plotAccuracy( i, acc );

% cp = classperf(id,dTe);
% get(cp);

% stats = confusionmatStats(dTe, id);

%%Regiao de Decisao 
%[XY] = deciosionregion(dataset, h);
