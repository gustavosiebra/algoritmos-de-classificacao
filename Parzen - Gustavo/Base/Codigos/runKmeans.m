%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%% Variaveis de limpeza
clc;
clear all;
close all;

%% Step 1: Read Image
he = imread('flagJapan.jpg');
figure, imshow(he);

%% Step 2: Convert Image from RGB Color Space to L*a*b* Color Space
cform = makecform('srgb2lab');
lab_he = applycform(he,cform);

%% Step 3: Classify the Colors in 'a*b*' Space Using K-Means Clustering
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 2;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance', ...
                            'sqEuclidean', 'Replicates',3);

%% Step 4: Label Every Pixel in the Image Using the Results from KMEANS                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure, imshow(pixel_labels,[]), title('image labeled by cluster index');