%% ESEMPIO: Linea Elettrica Trifase 380 kV
%
% Questo esempio mostra come calcolare il campo magnetico generato da una
% linea elettrica ad alta tensione (380 kV) con configurazione trifase.
%
% SCENARIO:
%   Una linea elettrica 380 kV passa a 15 metri di altezza sopra un terreno.
%   I tre cavi sono disposti orizzontalmente con separazione di 8 metri.
%   La corrente efficace è 1000 A.
%   Vogliamo determinare la fascia di rispetto.
%
% Autore: Federico Sabbadini
% Data: 2024

%% SETUP
close all; clc; clear;
addpath('../src/core');  % Percorso funzioni

%% PARAMETRI DEL PROBLEMA

% Corrente efficace nella linea [A]
I0 = 1000;

% Posizioni dei tre cavi (sistema trifase orizzontale)
%   Fase R: x = -8 m
%   Fase S: x =  0 m (centro)
%   Fase T: x = +8 m
%   Tutti a 15 m di altezza dal suolo
altezza_cavi = 15;  % [m]
separazione = 8;    % [m]

cavi = [-separazione, altezza_cavi;   % Fase R
         0,           altezza_cavi;   % Fase S
         separazione, altezza_cavi];  % Fase T

% Sfasamento trifase (120° tra le fasi)
fasi = [0, 2*pi/3, 4*pi/3];  % radianti

%% GRIGLIA DI CALCOLO

% Area di interesse: da -60 a +60 m in x, da 0 a 40 m in y (sopra suolo)
x = -60:0.5:60;
y = 0:0.5:40;
[X, Y] = meshgrid(x, y);

%% CALCOLO DEL CAMPO MAGNETICO

% Permeabilità del vuoto
mu0 = 4*pi*1e-7;

% Inizializza le componenti del campo
Bx_tot = zeros(size(X));
By_tot = zeros(size(Y));

% Somma i contributi dei tre cavi
for i = 1:3
    % Corrente complessa (con sfasamento)
    I = I0 * exp(1j * fasi(i));
    
    % Posizione del cavo
    xc = cavi(i, 1);
    yc = cavi(i, 2);
    
    % Distanza dagli osservatori
    R = sqrt((X - xc).^2 + (Y - yc).^2);
    R(R < 0.01) = 0.01;  % Evita divisione per zero
    
    % Campo magnetico (modulo)
    B = mu0 * I ./ (2 * pi * R);
    
    % Componenti (campo tangenziale al cerchio centrato nel cavo)
    Bx = -B .* (Y - yc) ./ R;
    By =  B .* (X - xc) ./ R;
    
    % Somma vettoriale
    Bx_tot = Bx_tot + Bx;
    By_tot = By_tot + By;
end

% Modulo del campo totale [T] → [μT]
B_tot = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2);
B_uT = B_tot * 1e6;

%% VISUALIZZAZIONE

% --- Grafico 1: Superficie 3D del campo ---
figure('Name', 'Campo B - Linea Trifase 380 kV', 'Position', [100, 100, 800, 600]);
surf(x, y, B_uT, 'EdgeColor', 'none');
colormap('hot');
colorbar;
xlabel('Distanza orizzontale [m]');
ylabel('Altezza dal suolo [m]');
zlabel('B [μT]');
title('Campo Magnetico - Linea 380 kV Trifase');
view(45, 30);
grid on;

% Marca i cavi
hold on;
for i = 1:3
    plot3(cavi(i,1), cavi(i,2), max(B_uT(:))/2, 'ko', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
end
hold off;

% --- Grafico 2: Curve isolivello (limiti normativi) ---
figure('Name', 'Curve Isolivello - Limiti Normativi', 'Position', [150, 150, 800, 600]);

% Limiti: 3 μT (qualità), 10 μT (attenzione), 100 μT (esposizione)
livelli = [0.3, 1, 3, 10, 30, 100];
[c, h] = contour(x, y, B_uT, livelli, 'LineWidth', 1.5);
clabel(c, h, 'FontSize', 10);
colormap('jet');
colorbar;

% Evidenzia i limiti normativi
hold on;
[c3, ~] = contour(x, y, B_uT, [3, 3], 'g', 'LineWidth', 3);
[c10, ~] = contour(x, y, B_uT, [10, 10], 'y', 'LineWidth', 3);
[c100, ~] = contour(x, y, B_uT, [100, 100], 'r', 'LineWidth', 3);

% Marca i cavi
for i = 1:3
    plot(cavi(i,1), cavi(i,2), 'ko', 'MarkerSize', 12, 'MarkerFaceColor', 'b');
end

% Linea del suolo
plot([-60, 60], [0, 0], 'k-', 'LineWidth', 2);
text(0, -2, 'SUOLO', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

hold off;

xlabel('Distanza orizzontale [m]');
ylabel('Altezza dal suolo [m]');
title('Curve Isolivello - Limiti Normativi Italiani');
legend('Contorni', '3 μT (Qualità)', '10 μT (Attenzione)', '100 μT (Esposizione)', ...
       'Location', 'northeast');
axis equal;
grid on;
ylim([0, 40]);

% --- Grafico 3: Profilo al suolo ---
figure('Name', 'Profilo Campo B al Suolo', 'Position', [200, 200, 800, 400]);

% Estrai il campo al livello del suolo (y = 0, prima riga)
% In realtà prendiamo y = 1 m per evitare la singolarità
idx_suolo = find(y >= 1, 1);
B_suolo = B_uT(idx_suolo, :);

plot(x, B_suolo, 'b-', 'LineWidth', 2);
hold on;

% Linee dei limiti
yline(100, 'r--', '100 μT', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');
yline(10, 'y--', '10 μT', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');
yline(3, 'g--', '3 μT', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');

hold off;

xlabel('Distanza dalla linea [m]');
ylabel('Campo B [μT]');
title(sprintf('Profilo del Campo B a %.0f m dal suolo', y(idx_suolo)));
grid on;
xlim([-60, 60]);
ylim([0, max(B_suolo)*1.1]);

%% ANALISI DELLE DISTANZE DI SICUREZZA

fprintf('\n========================================\n');
fprintf('ANALISI LINEA TRIFASE 380 kV\n');
fprintf('========================================\n\n');
fprintf('Parametri:\n');
fprintf('  Corrente: %d A (efficace)\n', I0);
fprintf('  Altezza cavi: %.0f m\n', altezza_cavi);
fprintf('  Separazione cavi: %.0f m\n\n', separazione);

fprintf('Campo B al suolo (sotto la linea): %.2f μT\n\n', B_uT(idx_suolo, x==0));

% Trova le distanze per i vari livelli
limiti_analisi = [100, 10, 3];
nomi = {'Limite esposizione', 'Valore attenzione', 'Obiettivo qualità'};

fprintf('Distanze di sicurezza (dal centro della linea):\n');
for i = 1:length(limiti_analisi)
    liv = limiti_analisi(i);
    
    % Trova dove il campo scende sotto il limite (al suolo)
    idx_ok = find(B_suolo < liv);
    if ~isempty(idx_ok)
        % Prendi la distanza minima (più vicina al centro)
        dist = min(abs(x(idx_ok)));
        fprintf('  %s (%d μT): %.1f m\n', nomi{i}, liv, dist);
    else
        fprintf('  %s (%d μT): sempre sotto il limite\n', nomi{i}, liv);
    end
end

fprintf('\n========================================\n');
fprintf('Nota: la fascia di rispetto per nuove costruzioni\n');
fprintf('dovrebbe essere calcolata con il valore di 3 μT.\n');
fprintf('========================================\n');
