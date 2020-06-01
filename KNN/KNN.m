%% @autor: Gustavo Siebra
% IFCE - Campus Fortaleza
% Programa de Pos-Graduacao em Ciencias da Computacao - PPGCC
% Disciplina: Machine Learning

%%
function [ndTr,nC,acuracia] = KNN(dTr,xTr,dTe,xTe,numoftestdata,numoftrainingdata,k)
    
    acuracia = 0;
    
    for sample = 1:numoftestdata

        %Step 3: Computing euclidean distance for each testdata
        euclideandistance = sum((repmat(xTe(sample,:),numoftrainingdata,1)- xTr).^2,2);

        %Step 4: compute k nearest neighbors and store them in an array
        [dist, position] = sort(euclideandistance,'ascend');

        ndTr = dTr(position);
        
        %Calculo da Moda
        nC(sample) = mode(ndTr(1:k,:));
        
        if(nC(sample) == dTe(sample)) 
            acuracia = acuracia + 1;
        end
    end
    nC = nC';
end

