%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% carregando arquivo
img_orig = imread('flagJapan.jpg');
% img_orig = imread('flagEUA1.jpg');
% img_orig = imread('flagItaly.jpg');
% img_orig = imread('flagFrance.jpg');
% img_orig = imread('flagBrazil.jpg');

%% Indique o numero de Classes
nC = input('Enter the number of Class:  ');

%% Capturando a base de Dados Treino
[imgSelec] = captImage(nC, img_orig);

%% Montando a base de Dados Treino
dadosTreino = baseDate(imgSelec, '');

%% Montando a base de Dados Teste
imagem{1} = img_orig;
dadosTeste = baseDate(imagem, 'teste');

%% Parzen Treino
fprintf('Treinando...\n')
tic
[prior, result] = parzenTreino(dadosTreino);

%% Parzen Teste
fprintf('Testando...\n')
h = 3;
[Yh, ~] = parzenTeste(h, dadosTeste, prior, result);
toc

Yh = Yh(dadosTeste.ic);

%% Convertendo a resposta em imagem
[linhas colunas ~] = size(img_orig);
% 
% newImg = reshape(Yh,[colunas, linhas])';
newImg = reshape(Yh,[linhas, colunas]);
h = figure;
image(newImg), colormap('flag')
axis off;

% print(h, '-depsc', 'segmentacaoEUA.eps');
