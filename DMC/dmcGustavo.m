%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%%
clc;
clear all;
close all;

%% Carregando arquivo
%data = load ('iris.txt');
data = load ('wine.txt');
    
%% Definicao do numero de realizacoes.
R = 10;
confMatrix = zeros(0,R);

for r = 1:R    
    %% Normalizacao dos dados.
    dataset = normalizeData(data);

    %% Embaralhar base de dados.
    dataset = randomizeData(dataset);

    %% Separacao dos dados.
    [dataTr,dataTe,xTr,dTr,xTe,dTe, att] = separateData(dataset);

    %% Treinamento
    n1=0; n2=0; n3=0;
    media1 = zeros(1,att); media2 = zeros(1,att); media3 = zeros(1,att); 

    for i2=1:size(dataTr,1), %%loop da matriz de treinamento
        p = dataTr(i2, 1:att); %%classe do momento
        switch dataTr(i2, att+1)
           case (1), media1 = media1*(n1/(n1+1)) + (p/(n1+1)), n1 = n1+1;
           case (2), media2 = media2*(n2/(n2+1)) + (p/(n2+1)), n2 = n2+1;
           case (3), media3 = media3*(n3/(n3+1)) + (p/(n3+1)), n3 = n3+1;
        end
    end
    v_medio = [[media1, 1]; [media2, 2]; [media3, 3]];
    
    %% Teste - Calculo do DMC
    n11=0; n22=0; n33=0;
    res = []; media11 = 0; media22 = 0; media33 = 0; 
    for i=1:size(dataTe,1) %%loop da matriz de teste
        p=dataTe(i,:); %%padrao do momento
        m_dist = []; %% soma os vetores de padroes e eleva os termos ao quadrado
        m_dist = [(p(:,1:att)-v_medio(1,1:att)).^2; (p(:,1:att)-v_medio(2,1:att)).^2; (p(:,1:att)-v_medio(3,1:att)).^2];
        m_dist = sqrt(sum(m_dist, 2)); %%matriz de distancias
        m_dist = [m_dist, v_medio(:,att+1)]; %%associo as distancias a classe correspondente
        p_classe = find(m_dist == min(m_dist(:,1)));
        classe = [];
        switch p_classe
           case 1, classe = [p, 1], v_medio(1,1:att) = v_medio(1,1:att)*(n11/(n11+1)) + (p(:,1:att)/(n11+1)), n11 = n11+1; %%recalcular m_medio
           case 2, classe = [p, 2], v_medio(2,1:att) = v_medio(2,1:att)*(n22/(n22+1)) + (p(:,1:att)/(n22+1)), n22 = n22+1; %%recalcular m_medio
           case 3, classe = [p, 3], v_medio(3,1:att) = v_medio(3,1:att)*(n33/(n33+1)) + (p(:,1:att)/(n33+1)), n33 = n33+1; %%recalcular m_medio
           otherwise classe = [p, 4];
        end
        res = [res; classe];
    end          
    %% Acuracia
    acc(r) = acuracia(res(:,att+2), dTe);
end

%% Plot da Acuracia
[accMedia, desvioPadrao] = plotAccuracy( r, acc );
disp(['media acuracia = ',num2str(accMedia*100),'%'])  