function [accMedia, desvioPadrao] = plotAccuracy( r, acc )
%% Parametros:
% Entrada:  
%   r       - Numero de iteracoes.
%   acc     - Acuracia.

% Saida:
%   accMedia       - Acuracia Media
%   desvioPadrao   - Desvio Padrao

%% Media e Desvio Padrao
accMedia = mean(acc);
desvioPadrao = std(acc);

%% Plot
y = linspace(0,r);
h = figure; 
plot(acc, '--bo',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]); 
hold on
plot(y,accMedia, '-*r');  
xlabel('Iterações','FontSize',10);
ylabel('Acuracia','FontSize',10);
grid on
legend('Acurácia','Média',...
    'Location','northoutside','Orientation','horizontal')

print (h, '-depsc', 'plotAccDerm_type4.eps');

end

