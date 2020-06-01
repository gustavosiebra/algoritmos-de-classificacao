%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Carregando arquivo
% data = load('iris.txt');
data = load('iris.txt');
% data = load('column.txt');

%% Iterações
R = 25;
% Alocando as matrizes das métricas.
acc = zeros(1,R);
confMat = zeros(1,R);

for r = 1:R
    %% Normalizacao dos dados.
    dataset = normalizeData(data);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    [dataTr,dataTe,xTr,dTr,xTe,dTe, att] = separateData(dataset);

    %% Bayes Treino
    [ndTr, prior, media, sigma] = bayesTraining(xTr, dTr);

    %% Bayes Teste
    [id, F] = bayesTest(xTe, dTe, ndTr, prior, media, sigma,1);

    %% Acuracia
    acc(r) = acuracia(id, dTe);
end

% % Plot Caracteristicas
tmp1 = plotLabelsTest(dataset);
% 
% % Plot da Acuracia
[accMedia, desvioPadrao] = plotAccuracy( r, acc );
% 
% %% Plot mvnpdf
[XY] = plotmvnpdf(dataset, 1);
% 
% %% Regiao de Decisao
[XY] = deciosionregion(dataset, 1);