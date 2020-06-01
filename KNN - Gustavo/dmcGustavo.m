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
    
% Definicao do numero de realizacoes.
R = 10;
confMatrix = zeros(3,3);

for r = 1:R
        %%
        %Organizacao dos Dados
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
        
        %%
        % Treinamento
        media1 = [0,0,0,0]; media2 = [0,0,0,0]; media3 = [0,0,0,0]; n1=0; n2=0; n3=0;

        for i2=1:size(dataTr,1), %%loop da matriz de treinamento
            p = dataTr(i2, 1:4); %%classe do momento
            switch dataTr(i2, 5)
               case (1), media1 = media1*(n1/(n1+1)) + (p/(n1+1)), n1 = n1+1;
               case (2), media2 = media2*(n2/(n2+1)) + (p/(n2+1)), n2 = n2+1;
               case (3), media3 = media3*(n3/(n3+1)) + (p/(n3+1)), n3 = n3+1;
            end
        end

        v_medio = [[media1, 1]; [media2, 2]; [media3, 3]];


        %%
        % Calculo do DMC

        res = []; media11 = 0; media22 = 0; media33 = 0; n11=0; n22=0; n33=0;

        for i=1:size(dataTe,1) %%loop da matriz de teste
            p=dataTe(i,:); %%padrao do momento

            m_dist = []; %% soma os vetores de padroes e eleva os termos ao quadrado
            m_dist = [(p(:,1:4)-v_medio(1,1:4)).^2; (p(:,1:4)-v_medio(2,1:4)).^2; (p(:,1:4)-v_medio(3,1:4)).^2];
            m_dist = sqrt(sum(m_dist, 2)); %%matriz de distancias
            m_dist = [m_dist, v_medio(:,5)]; %%associo as distancias a classe correspondente
            p_classe = find(m_dist == min(m_dist(:,1)));
            classe = [];
            switch p_classe
               case 1, classe = [p, 1], v_medio(1,1:4) = v_medio(1,1:4)*(n11/(n11+1)) + (p(:,1:4)/(n11+1)), n11 = n11+1; %%recalcular m_medio
               case 2, classe = [p, 2], v_medio(2,1:4) = v_medio(2,1:4)*(n22/(n22+1)) + (p(:,1:4)/(n22+1)), n22 = n22+1; %%recalcular m_medio
               case 3, classe = [p, 3], v_medio(3,1:4) = v_medio(3,1:4)*(n33/(n33+1)) + (p(:,1:4)/(n33+1)), n33 = n33+1; %%recalcular m_medio
               otherwise classe = [p, 4];
            end
            res = [res; classe];
        end      

        %%calcular acuracia do classificador
        acuracia = 0;

        for i2 = 1:size(res,1)
            if isequal(res(i2,5),res(i2,6))/size(dataTe,1);
                acuracia = acuracia + 1;
            end
        end

        aC(r) = acuracia/size(dataTe,1) * 100;
        acuraciaMedia(r) = mean(aC);
        desvioPadrao(r) = std(aC);
        
        %%
        %Matriz Confusao
        
        [C,order] = confusionmat(res(:,6), dTe);
        confMatrix = C + confMatrix;

end

%%
%Plots

figure, plot(aC); ylabel('Acuracia','FontSize',10);
figure, plot(desvioPadrao); 
xlabel('K','FontSize',10);
ylabel('Desvio Padrao','FontSize',10);
figure, plot(acuraciaMedia); 
xlabel('K','FontSize',10);
ylabel('Acuracia','FontSize',10);

    
