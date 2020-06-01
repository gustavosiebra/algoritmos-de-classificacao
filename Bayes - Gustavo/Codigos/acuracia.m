function [acc] = acuracia(id, dTe)
    %% Parametros:
    % Entrada:  
    %   id   - labels
    %   dTe     - Classes de teste.
    
    %% Matriz Confusao
    confMat = confusionmat(dTe,id);
    disp('confusion matrix:')
    disp(confMat)
    
    %% Acuracia
    cm = confMat./sum(confMat(:));
    acc = trace(cm) / sum(cm(:));
    disp(['accuracy = ',num2str(acc*100),'%'])
    
end

