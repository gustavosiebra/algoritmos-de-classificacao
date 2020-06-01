function [dados] = baseDate(imgSelec, tipo)
    %% Parametros:
    % Entrada:
    %   nC       - Numero de Classes.
    %   img_orig - Imagem Original.
    %
    % Saida:
    %   dados    - Base de completa dados
    
    %% Montando a Base
    dados.x = [];
    dados.y = [];

    for i = 1: size(imgSelec,2)
        [linhas, colunas, ~] = size(imgSelec{i});
        x = [reshape(imgSelec{i}(:,:,1), [1 linhas*colunas])' ...
                reshape(imgSelec{i}(:,:,2), [1 linhas*colunas])' ...
                reshape(imgSelec{i}(:,:,3), [1 linhas*colunas])'];
        
        %%
        if (strcmp(tipo, 'teste') == 1)
            dados.x = [dados.x; x];
        else
            x =  unique(x,'rows');
            dados.y = [dados.y; i*ones(size(x,1),1)];
            dados.x = [dados.x; x];
        end
        
        
        dados.x =  double(dados.x);

        if (strcmp(tipo, 'teste') == 1)
            [x, ~, ic] =  unique(dados.x,'rows');
            dados.x = x;
            dados.ic = ic;
        end
        
    end
    
end
